const std = @import("std");
const http = std.http;

const errors = @import("errors");
const types = @import("types");

const ZiogramError = errors.ZiogramError;

const ClientOptions = @import("../client/http_options.zig");
const TelegramAPI = @import("../client/api.zig");

const InputFile = types.InputFile;
const Response = types.Response;

const PRODUCTION = TelegramAPI.PRODUCTION;

pub const FilesMap = std.StringHashMapUnmanaged(InputFile);

client: http.Client,
allocator: std.mem.Allocator,
options: ClientOptions,

pub fn init(allocator: std.mem.Allocator, io: std.Io, options: ClientOptions) !*@This() {
    const self = try allocator.create(@This());
    errdefer allocator.destroy(self);

    self.* = .{
        .client = http.Client{
            .allocator = allocator,
            .io = io,
            .read_buffer_size = options.read_buffer_size,
            .write_buffer_size = options.write_buffer_size,
        },
        .allocator = allocator,
        .options = options,
    };

    self.client.connection_pool.free_size = options.pool_size;

    if (options.proxy) |p| {
        const p_heap = try allocator.create(http.Client.Proxy);
        errdefer allocator.destroy(p_heap);

        p_heap.* = p.*;

        self.options.proxy = p_heap;
        self.client.http_proxy = p_heap;
        self.client.https_proxy = p_heap;
    }

    return self;
}

pub fn deinit(self: *@This()) void {
    self.client.deinit();
    if (self.options.proxy) |p| {
        self.allocator.destroy(p);
    }
    const allocator = self.allocator;
    allocator.destroy(self);
}

pub fn checkResponse(
    allocator: std.mem.Allocator,
    method: anytype,
    status_code: std.http.Status,
    content: []const u8,
) !Response(@TypeOf(method).Result) {
    const Method = @TypeOf(method);
    const T = Method.Result;

    const response = std.json.parseFromSliceLeaky(
        Response(T),
        allocator,
        content,
        .{
            .ignore_unknown_fields = true,
            .allocate = .alloc_always,
        },
    ) catch |err| {
        var decode_err = try errors.makeDecodeError(allocator, err, content);
        std.log.err("{s}: {s}", .{ decode_err.label, decode_err.message });
        defer decode_err.deinit();
        return ZiogramError.ClientDecodeError;
    };

    if (status_code.class() == .success and response.ok) {
        return response;
    }

    const description = response.description orelse "no description";
    const error_code = response.error_code orelse 0;

    if (response.parameters) |parameters| {
        const method_chat_id = if (@hasField(Method, "chat_id")) method.chat_id else null;

        if (parameters.retry_after) |retry_after| {
            var err_detail = try errors.makeRetryAfter(
                allocator,
                Method.method_name,
                method_chat_id,
                @intCast(retry_after),
                description,
            );
            std.log.err("{s}: {s}", .{ err_detail.label, err_detail.message });
            defer err_detail.deinit();
            return ZiogramError.TelegramRetryAfter;
        }

        if (parameters.migrate_to_chat_id) |migrate_to_chat_id| {
            var err_detail = try errors.makeMigrateToChat(
                allocator,
                method_chat_id,
                migrate_to_chat_id,
                description,
            );
            defer err_detail.deinit();
            std.log.err("{s}: {s}", .{ err_detail.label, err_detail.message });
            return ZiogramError.TelegramMigrateToChat;
        }
    }

    var api_err = try errors.makeTelegramError(allocator, Method.method_name, error_code, description);
    defer api_err.deinit();
    std.log.err("{s}: {s}\n  └─ Info: {s}", .{ api_err.label, api_err.message, api_err.url orelse "N/A" });

    return switch (status_code) {
        .bad_request => ZiogramError.TelegramBadRequest,
        .unauthorized => ZiogramError.TelegramUnauthorizedError,
        .forbidden => ZiogramError.TelegramForbiddenError,
        .not_found => ZiogramError.TelegramNotFound,
        .conflict => ZiogramError.TelegramConflictError,
        .payload_too_large => ZiogramError.TelegramEntityTooLarge,
        .too_many_requests => ZiogramError.TelegramRetryAfter,
        else => if (status_code.class() == .server_error)
            ZiogramError.TelegramServerError
        else
            ZiogramError.TelegramAPIError,
    };
}

pub fn prepareValue(
    allocator: std.mem.Allocator,
    io: std.Io,
    jw: anytype,
    value: anytype,
    files: *FilesMap,
) !void {
    const T = @TypeOf(value);

    switch (@typeInfo(T)) {
        .optional => {
            if (value) |v| try prepareValue(allocator, io, jw, v, files) else try jw.write(null);
        },

        .@"union" => {
            if (comptime T == InputFile) {
                switch (value) {
                    .file_id => |id| try jw.write(id),
                    .url => |u| try jw.write(u.url),
                    inline .fs, .buffer => {
                        var random_bytes: [8]u8 = undefined;
                        std.Io.random(io, &random_bytes);

                        const hex_name = std.fmt.bytesToHex(random_bytes, .lower);

                        const key = try std.fmt.allocPrint(allocator, "f_{s}", .{hex_name});
                        try files.put(allocator, key, value);

                        const attach_str = try std.fmt.allocPrint(allocator, "attach://{s}", .{key});
                        defer allocator.free(attach_str);
                        try jw.write(attach_str);
                    },
                }
                return;
            }
            switch (value) {
                inline else => |payload| try jw.write(payload),
            }
        },

        .@"struct" => {
            try jw.beginObject();
            inline for (std.meta.fields(T)) |field| {
                if (comptime isMetaField(field.name)) continue;

                const field_val = @field(value, field.name);
                const is_optional = comptime @typeInfo(field.type) == .optional;

                if (comptime is_optional) {
                    if (field_val) |v| {
                        try jw.objectField(field.name);
                        try prepareValue(allocator, io, jw, v, files);
                    }
                } else {
                    try jw.objectField(field.name);
                    try prepareValue(allocator, io, jw, field_val, files);
                }
            }
            try jw.endObject();
        },

        .pointer => |ptr| {
            if (comptime ptr.size == .slice and ptr.child == u8) {
                try jw.write(value);
            } else if (comptime ptr.size == .slice) {
                try jw.beginArray();
                for (value) |item| try prepareValue(allocator, io, jw, item, files);
                try jw.endArray();
            } else {
                try prepareValue(allocator, io, jw, value.*, files);
            }
        },

        inline else => try jw.write(value),
    }
}

fn isMetaField(comptime name: []const u8) bool {
    return std.mem.eql(u8, name, "Result") or std.mem.eql(u8, name, "method_name");
}

fn writePart(
    self: *@This(),
    writer: *std.Io.Writer,
    name: []const u8,
    value: anytype,
    boundary: []const u8,
) !void {
    const T = @TypeOf(value);

    try writer.print("--{s}\r\n", .{boundary});
    try writer.print("Content-Disposition: form-data; name=\"{s}\"", .{name});

    if (comptime T == types.InputFile) {
        switch (value) {
            .fs, .buffer => {
                var filename_buf: [512]u8 = undefined;
                try writer.print("; filename=\"{s}\"\r\n", .{value.getFilename(&filename_buf)});
                try writer.writeAll("Content-Type: application/octet-stream\r\n\r\n");
                try value.writeTo(self.client.io, writer, &self.client);
            },
            .url => |u| {
                try writer.writeAll("\r\n\r\n");
                try writer.writeAll(u.url);
            },
            .file_id => |id| {
                try writer.writeAll("\r\n\r\n");
                try writer.writeAll(id);
            },
        }
    } else {
        try writer.writeAll("\r\n\r\n");

        switch (@typeInfo(T)) {
            .optional => if (value) |v| try writePart(self, writer, name, v, boundary),
            .@"union" => {
                if (comptime T == types.ChatId) {
                    switch (value) {
                        .id => |id| try writer.print("{d}", .{id}),
                        .username => |u| try writer.writeAll(u),
                    }
                } else {
                    var stringifier = std.json.Stringify{
                        .writer = writer,
                        .options = .{ .emit_null_optional_fields = false },
                    };
                    try stringifier.write(value);
                }
            },
            .@"struct" => {
                var stringifier = std.json.Stringify{
                    .writer = writer,
                    .options = .{ .emit_null_optional_fields = false },
                };
                try stringifier.write(value);
            },
            .@"enum" => try writer.writeAll(@tagName(value)),
            .bool => try writer.writeAll(if (value) "true" else "false"),
            .int, .float => try writer.print("{d}", .{value}),
            .pointer => |ptr| {
                if (ptr.size == .slice and ptr.child == u8) {
                    try writer.writeAll(value);
                } else {
                    try writer.print("{any}", .{value});
                }
            },
            else => try writer.print("{any}", .{value}),
        }
    }
    try writer.writeAll("\r\n");
}

fn writeMultipart(
    self: *@This(),
    writer: *std.Io.Writer,
    method: anytype,
    boundary: []const u8,
) !void {
    const MethodType = @TypeOf(method);

    inline for (std.meta.fields(MethodType)) |field| {
        if (comptime isMetaField(field.name)) continue;

        const value = @field(method, field.name);
        const is_optional = comptime @typeInfo(field.type) == .optional;

        if (comptime is_optional) {
            if (value) |final_value| {
                try self.writePart(writer, field.name, final_value, boundary);
            }
        } else {
            try self.writePart(writer, field.name, value, boundary);
        }
    }
    try writer.print("--{s}--\r\n", .{boundary});
}

pub fn makeRequest(
    self: *@This(),
    allocator: std.mem.Allocator,
    token: []const u8,
    method: anytype,
) !@TypeOf(method).Result {
    const Method = @TypeOf(method);
    const url_str = try self.options.api.apiUrl(allocator, token, Method.method_name);

    var has_files = false;
    inline for (std.meta.fields(Method)) |field| {
        if (field.type == types.InputFile or field.type == ?types.InputFile) {
            has_files = true;
            break;
        }
    }

    const boundary = "----ZiogramBoundary42";
    const content_type: []const u8 = if (has_files)
        "multipart/form-data; boundary=----ZiogramBoundary42"
    else
        "application/json";

    var payload_aw = std.Io.Writer.Allocating.init(allocator);
    defer payload_aw.deinit();

    if (has_files) {
        try self.writeMultipart(&payload_aw.writer, method, boundary);
    } else {
        var jws = std.json.Stringify{
            .writer = &payload_aw.writer,
            .options = .{ .emit_null_optional_fields = false },
        };
        var files_map = FilesMap.empty;
        try prepareValue(allocator, self.client.io, &jws, method, &files_map);
    }

    const payload_data = payload_aw.written();

    var response_aw = std.Io.Writer.Allocating.init(allocator);
    defer response_aw.deinit();

    const result = self.client.fetch(.{
        .location = .{ .url = url_str },
        .payload = if (payload_data.len > 0) payload_data else null,
        .response_writer = &response_aw.writer,
        .headers = .{
            .content_type = .{ .override = content_type },
            .connection = .{ .override = "close" },
        },
    }) catch |err| {
        if (err == error.NameServerFailure or err == error.TemporaryNameServerFailure) {
            std.log.err("DNS resolution failed. Check your internet connection.", .{});
            return ZiogramError.NameServerFailure;
        }
        std.log.err("Network error while calling '{s}': {s}", .{ Method.method_name, @errorName(err) });
        return ZiogramError.TelegramNetworkError;
    };

    const response_content = response_aw.written();

    const response = try checkResponse(allocator, method, result.status, response_content);

    return response.result orelse return error.TelegramBadRequest;
}

pub fn streamContent(
    self: *@This(),
    url: []const u8,
    writer: *std.Io.Writer,
) !void {
    const uri = try std.Uri.parse(url);

    var req = try self.client.request(.GET, uri, .{
        .keep_alive = false,
    });
    defer req.deinit();

    try req.sendBodiless();

    var redirect_buf: [8 * 1024]u8 = undefined;
    var response = try req.receiveHead(&redirect_buf);

    const status_code = response.head.status;

    if (status_code.class() != .success) {
        return switch (status_code) {
            .unauthorized => ZiogramError.TelegramUnauthorizedError,
            .forbidden => ZiogramError.TelegramForbiddenError,
            .not_found => ZiogramError.TelegramNotFound,
            else => if (status_code.class() == .server_error)
                ZiogramError.TelegramServerError
            else
                ZiogramError.TelegramAPIError,
        };
    }

    var transfer_buf: [65536]u8 = undefined;
    const reader = response.reader(&transfer_buf);

    _ = reader.streamRemaining(writer) catch |err| switch (err) {
        error.ReadFailed => return response.bodyErr().?,
        error.WriteFailed => return ZiogramError.TelegramNetworkError,
    };
}
