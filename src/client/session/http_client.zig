const std = @import("std");
const http = std.http;
const FilesMap = @import("base.zig").FilesMap;
const BaseSession = @import("base.zig").BaseSession;
const BotOptions = @import("../../client/bot_options.zig").BotOptions;

const types = @import("../../types.zig");

const errors = @import("../../errors.zig");
const ZiogramError = errors.ZiogramError;

pub const ClientSession = struct {
    base: BaseSession,
    client: http.Client,
    allocator: std.mem.Allocator,
    io: std.Io,
    proxy: ?*http.Client.Proxy = null,

    pub fn init(allocator: std.mem.Allocator, io: std.Io, proxy: ?*const http.Client.Proxy) !*ClientSession {
        const self = try allocator.create(ClientSession);
        errdefer allocator.destroy(self);

        self.* = .{
            .base = BaseSession{},
            .client = http.Client{
                .allocator = allocator,
                .io = io,
            },
            .allocator = allocator,
            .io = io,
            .proxy = null,
        };

        if (proxy) |p| {
            const p_heap = try allocator.create(http.Client.Proxy);
            errdefer allocator.destroy(p_heap);

            p_heap.* = p.*;

            self.proxy = p_heap;
            self.client.http_proxy = p_heap;
            self.client.https_proxy = p_heap;
        }

        return self;
    }

    pub fn deinit(self: *ClientSession) void {
        self.client.deinit();
        if (self.proxy) |p| {
            self.allocator.destroy(p);
        }
        const allocator = self.allocator;
        allocator.destroy(self);
    }

    fn writePart(
        self: *ClientSession,
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
                    try writer.print("; filename=\"{s}\"\r\n", .{value.getFilename()});
                    try writer.writeAll("Content-Type: application/octet-stream\r\n\r\n");
                    try value.writeTo(self.io, writer);
                },
                .url, .file_id => |str| {
                    try writer.writeAll("\r\n\r\n");
                    try writer.writeAll(str);
                },
            }
        } else {
            try writer.writeAll("\r\n\r\n");

            const info = @typeInfo(T);
            switch (info) {
                .optional => if (value) |v| try self.writePart(writer, name, v, boundary), // Рекурсивно для опциональных
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
                .@"enum" => {
                    try writer.writeAll(@tagName(value));
                },
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
        self: *ClientSession,
        writer: *std.Io.Writer,
        method: anytype,
        boundary: []const u8,
        bot_options: ?BotOptions,
    ) !void {
        const MethodType = @TypeOf(method);

        inline for (std.meta.fields(MethodType)) |field| {
            if (comptime std.mem.eql(u8, field.name, "ReturnType") or std.mem.eql(u8, field.name, "api_method")) continue;

            var value = @field(method, field.name);
            const is_optional = comptime @typeInfo(field.type) == .optional;

            if (comptime is_optional) {
                if (value == null and bot_options != null) {
                    if (comptime @hasField(BotOptions, field.name)) {
                        value = @field(bot_options.?, field.name);
                    }
                }

                if (value) |final_value| {
                    try self.writePart(writer, field.name, final_value, boundary);
                }
            } else {
                try self.writePart(writer, field.name, value, boundary);
            }
        }
        try writer.print("--{s}--\r\n", .{boundary});
    }

    pub fn downloadFile(
        self: *ClientSession,
        allocator: std.mem.Allocator,
        token: []const u8,
        file_path: []const u8,
        writer: *std.Io.Writer,
    ) !void {
        if (self.base.api.is_local) {
            const local_path = try self.base.api.wrap_local_file.toLocal(allocator, file_path);
            defer allocator.free(local_path);

            const file = try std.Io.Dir.openFile(.cwd(), self.io, local_path, .{});
            defer file.close(self.io);

            var buf: [65536]u8 = undefined;
            var file_reader = file.reader(self.io, &buf);
            _ = try writer.sendFileReadingAll(&file_reader.interface, .unlimited);
            return;
        }

        const url_str = try self.base.api.fileUrl(allocator, token, file_path);
        const uri = try std.Uri.parse(url_str);

        var req = try self.client.request(.GET, uri, .{
            .keep_alive = false,
        });
        defer req.deinit();

        try req.sendBodiless();

        var redirect_buf: [8 * 1024]u8 = undefined;
        var response = try req.receiveHead(&redirect_buf);

        const status_code: u16 = @as(u16, @intFromEnum(response.head.status));
        if (status_code < 200 or status_code > 226) {
            return switch (status_code) {
                401 => ZiogramError.TelegramUnauthorizedError,
                403 => ZiogramError.TelegramForbiddenError,
                404 => ZiogramError.TelegramNotFound,
                500...599 => ZiogramError.TelegramServerError,
                else => ZiogramError.TelegramAPIError,
            };
        }

        var transfer_buf: [65536]u8 = undefined;
        const reader = response.reader(&transfer_buf);
        _ = reader.streamRemaining(writer) catch |err| switch (err) {
            error.ReadFailed => return response.bodyErr().?,
            error.WriteFailed => return ZiogramError.TelegramNetworkError,
        };
    }

    pub fn makeRequest(
        self: *ClientSession,
        allocator: std.mem.Allocator,
        token: []const u8,
        comptime Method: type,
        method: Method,
        bot_options: ?BotOptions,
    ) !Method.ReturnType {
        const url_str = try self.base.api.apiUrl(allocator, token, Method.api_method);

        var has_files = false;
        inline for (std.meta.fields(Method)) |field| {
            if (field.type == types.InputFile or field.type == ?types.InputFile) {
                has_files = true;
                break;
            }
        }

        const boundary = "----ZiogramBoundary42";
        var content_type: []const u8 = "application/json";

        var payload_aw = std.Io.Writer.Allocating.init(allocator);
        defer payload_aw.deinit();

        if (has_files) {
            content_type = try std.fmt.allocPrint(allocator, "multipart/form-data; boundary={s}", .{boundary});
            try self.writeMultipart(&payload_aw.writer, method, boundary, bot_options);
        } else {
            var jws = std.json.Stringify{
                .writer = &payload_aw.writer,
                .options = .{ .emit_null_optional_fields = false },
            };
            var files_map = FilesMap.empty;

            try self.base.prepareValue(allocator, self.io, &jws, method, &files_map, bot_options);
        }

        const payload_data = payload_aw.written();

        var response_aw = std.Io.Writer.Allocating.init(allocator);
        defer response_aw.deinit();

        const result = self.client.fetch(.{
            .location = .{ .url = url_str },
            .method = if (payload_data.len > 0) .POST else .GET,
            .payload = if (payload_data.len > 0) payload_data else null,
            .response_writer = &response_aw.writer,
            .headers = .{
                .content_type = .{ .override = content_type },
                .connection = .{ .override = "close" },
            },
        }) catch |err| {
            if (err == error.NameServerFailure or err == error.TemporaryNameServerFailure) {
                return ZiogramError.NameServerFailure;
            }
            return ZiogramError.TelegramNetworkError;
        };

        const status_code: u16 = @as(u16, @intFromEnum(result.status));
        const response_content = response_aw.written();

        const response = try self.base.checkResponse(
            allocator,
            Method,
            method,
            status_code,
            response_content,
        );

        return response.result orelse return error.TelegramBadRequest;
    }
};
