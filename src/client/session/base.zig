const std = @import("std");

const BotOptions = @import("../../client/bot_options.zig").BotOptions;
const TelegramAPI = @import("../../client/telegram_api.zig").TelegramAPI;
const PRODUCTION = @import("../../client/telegram_api.zig").PRODUCTION;

const Response = @import("../../types/response.zig").Response;
const InputFile = @import("../../types/input_file.zig").InputFile;

const errors = @import("../../errors.zig");
const ZiogramError = errors.ZiogramError;
const makeRetryAfter = errors.makeRetryAfter;
const makeMigrateToChat = errors.makeMigrateToChat;
const makeDecodeError = errors.makeDecodeError;
const makeTelegramError = errors.makeTelegramError;

pub const FilesMap = std.StringHashMapUnmanaged(InputFile);

pub const BaseSession = struct {
    api: TelegramAPI = PRODUCTION,

    pub fn checkResponse(
        self: BaseSession,
        allocator: std.mem.Allocator,
        comptime Method: type,
        method: Method,
        status_code: u16,
        content: []const u8,
    ) !Response(Method.ReturnType) {
        _ = self;
        const T = Method.ReturnType;

        const response = std.json.parseFromSliceLeaky(
            Response(T),
            allocator,
            content,
            .{
                .ignore_unknown_fields = true,
                .allocate = .alloc_always,
            },
        ) catch |err| {
            var decode_err = try makeDecodeError(allocator, err, content);
            std.log.err("{s}: {s}", .{ decode_err.label, decode_err.message });
            defer decode_err.deinit();
            return ZiogramError.ClientDecodeError;
        };

        if (status_code >= 200 and status_code <= 226 and response.ok) {
            return response;
        }

        const description = response.description orelse "no description";
        const error_code = response.error_code orelse 0;

        if (response.parameters) |params| {
            const method_chat_id = if (@hasField(Method, "chat_id")) method.chat_id else null;

            if (params.retry_after) |ra| {
                const err_detail = try makeRetryAfter(
                    allocator,
                    Method.api_method,
                    method_chat_id,
                    @intCast(ra),
                    description,
                );
                std.log.err("{s}: {s}", .{ err_detail.label, err_detail.message });
                defer err_detail.deinit();
                return ZiogramError.TelegramRetryAfter;
            }

            if (params.migrate_to_chat_id) |mid| {
                const err_detail = try makeMigrateToChat(
                    allocator,
                    method_chat_id,
                    mid,
                    description,
                );
                defer err_detail.deinit();
                std.log.err("{s}: {s}", .{ err_detail.label, err_detail.message });
                return ZiogramError.TelegramMigrateToChat;
            }
        }

        var api_err = try makeTelegramError(allocator, Method.api_method, error_code, description);
        std.log.err("{s}: {s}\n  └─ Info: {s}", .{ api_err.label, api_err.message, api_err.url orelse "N/A" });
        api_err.deinit();

        return switch (status_code) {
            400 => ZiogramError.TelegramBadRequest,
            401 => ZiogramError.TelegramUnauthorizedError,
            403 => ZiogramError.TelegramForbiddenError,
            404 => ZiogramError.TelegramNotFound,
            409 => ZiogramError.TelegramConflictError,
            413 => ZiogramError.TelegramEntityTooLarge,
            500...599 => ZiogramError.TelegramServerError,
            else => ZiogramError.TelegramAPIError,
        };
    }

    pub fn prepareValue(
        self: BaseSession,
        allocator: std.mem.Allocator,
        io: std.Io,
        jw: anytype,
        value: anytype,
        files: *FilesMap,
        bot_options: ?BotOptions,
    ) !void {
        const T = @TypeOf(value);

        switch (@typeInfo(T)) {
            .optional => {
                if (value) |v| try self.prepareValue(allocator, io, jw, v, files, bot_options) else try jw.write(null);
            },

            .@"union" => {
                if (comptime T == InputFile) {
                    switch (value) {
                        .file_id, .url => |str| try jw.write(str),
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

                    var field_val = @field(value, field.name);
                    const is_optional = comptime @typeInfo(field.type) == .optional;

                    if (comptime is_optional) {
                        if (bot_options) |o| {
                            if (field_val == null) {
                                if (comptime @hasField(BotOptions, field.name)) {
                                    field_val = @field(o, field.name);
                                }
                            }
                        }

                        if (field_val) |v| {
                            try jw.objectField(field.name);
                            try self.prepareValue(allocator, io, jw, v, files, null);
                        }
                    } else {
                        try jw.objectField(field.name);
                        try self.prepareValue(allocator, io, jw, field_val, files, null);
                    }
                }
                try jw.endObject();
            },

            .pointer => |ptr| {
                if (comptime ptr.size == .slice and ptr.child == u8) {
                    try jw.write(value);
                } else if (comptime ptr.size == .slice) {
                    try jw.beginArray();
                    for (value) |item| try self.prepareValue(allocator, io, jw, item, files, null);
                    try jw.endArray();
                } else {
                    try self.prepareValue(allocator, io, jw, value.*, files, null);
                }
            },

            inline else => try jw.write(value),
        }
    }

    fn isMetaField(comptime name: []const u8) bool {
        return std.mem.eql(u8, name, "ReturnType") or std.mem.eql(u8, name, "api_method");
    }
};
