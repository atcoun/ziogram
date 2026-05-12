const BaseSession = @This();

const std = @import("std");

const errors = @import("errors");
const ZiogramError = errors.ZiogramError;

const types = @import("types");
const Response = types.Response;
const InputFile = types.InputFile;

pub const FilesMap = std.StringHashMapUnmanaged(InputFile);

client: std.http.Client,

pub fn init(allocator: std.mem.Allocator, io: std.Io) BaseSession {
    return .{
        .client = .{
            .allocator = allocator,
            .io = io,
        },
    };
}

pub fn deinit(self: *BaseSession) void {
    self.client.deinit();
}

pub fn checkResponse(
    _: BaseSession,
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
    std.log.err("{s}: {s}\n  └─ Info: {s}", .{ api_err.label, api_err.message, api_err.url orelse "https://core.telegram.org/bots/api" });

    if (status_code.class() == .server_error) {
        return error.TelegramServerError;
    }

    return switch (status_code) {
        .bad_request => error.TelegramBadRequest,
        .unauthorized => error.TelegramUnauthorizedError,
        .forbidden => error.TelegramForbiddenError,
        .not_found => error.TelegramNotFound,
        .conflict => error.TelegramConflictError,
        .payload_too_large => error.TelegramEntityTooLarge,
        .too_many_requests => error.TelegramRetryAfter,
        else => error.TelegramAPIError,
    };
}

pub fn isMetaField(
    comptime name: []const u8,
) bool {
    return std.mem.eql(u8, name, "Result") or std.mem.eql(
        u8,
        name,
        "method_name",
    );
}

pub fn prepareValue(
    self: BaseSession,
    allocator: std.mem.Allocator,
    io: std.Io,
    jw: anytype,
    value: anytype,
    files: *FilesMap,
) !void {
    const T = @TypeOf(value);

    switch (@typeInfo(T)) {
        .optional => {
            if (value) |v| try self.prepareValue(allocator, io, jw, v, files) else try jw.write(null);
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
                        try self.prepareValue(allocator, io, jw, v, files);
                    }
                } else {
                    try jw.objectField(field.name);
                    try self.prepareValue(allocator, io, jw, field_val, files);
                }
            }
            try jw.endObject();
        },

        .pointer => |ptr| {
            if (comptime ptr.size == .slice and ptr.child == u8) {
                try jw.write(value);
            } else if (comptime ptr.size == .slice) {
                try jw.beginArray();
                for (value) |item| try self.prepareValue(allocator, io, jw, item, files);
                try jw.endArray();
            } else {
                try self.prepareValue(allocator, io, jw, value.*, files);
            }
        },

        inline else => try jw.write(value),
    }
}
