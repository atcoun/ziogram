const ClientSession = @This();

const std = @import("std");

const Bot = @import("../../client/bot.zig");
const BaseSession = @import("./base.zig");
const FilesMap = BaseSession.FilesMap;
const isMetaField = BaseSession.isMetaField;
const TelegramAPI = @import("../../client/telegram.zig");

const errors = @import("errors");
const ZiogramError = errors.ZiogramError;

const types = @import("types");
const ChatId = types.ChatId;
const InputFile = types.InputFile;

const Options = struct {
    pool: usize = 10,
    api: TelegramAPI = TelegramAPI.server,
};
const default_timeout: i32 = 60;

base: BaseSession,
allocator: std.mem.Allocator,
io: std.Io,
options: Options,

pub fn init(
    allocator: std.mem.Allocator,
    io: std.Io,
    options: Options,
) !ClientSession {
    var session = ClientSession{
        .base = BaseSession.init(allocator, io),
        .allocator = allocator,
        .io = io,
        .options = options,
    };
    try session.base.client.connection_pool.resize(io, options.pool);
    return session;
}

pub fn deinit(self: *ClientSession) void {
    self.base.deinit();
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

    if (comptime T == InputFile) {
        switch (value) {
            .fs, .buffer => {
                var filename_buf: [512]u8 = undefined;
                try writer.print("; filename=\"{s}\"\r\n", .{value.getFilename(&filename_buf)});
                try writer.writeAll("Content-Type: application/octet-stream\r\n\r\n");
                try value.writeTo(self.io, writer, &self.base.client);
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
                if (comptime T == ChatId) {
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
    self: *ClientSession,
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
    self: *ClientSession,
    allocator: std.mem.Allocator,
    bot: Bot,
    method: anytype,
    request_timeout: ?i32,
) !@TypeOf(method).Result {
    const Method = @TypeOf(method);
    const io = self.io;
    const timeout = request_timeout orelse default_timeout;

    const SelectResult = union(enum) {
        request: anyerror!Method.Result,
        timeout: void,
    };

    var select_buf: [2]SelectResult = undefined;
    var select = std.Io.Select(SelectResult).init(io, &select_buf);

    const RequestCtx = struct {
        session: *ClientSession,
        allocator: std.mem.Allocator,
        bot: Bot,
        method: Method,

        fn run(ctx: @This()) anyerror!Method.Result {
            return ctx.session.request(
                ctx.allocator,
                ctx.bot,
                ctx.method,
            );
        }
    };

    select.concurrent(.request, RequestCtx.run, .{.{
        .session = self,
        .allocator = allocator,
        .bot = bot,
        .method = method,
    }}) catch |err| switch (err) {
        error.ConcurrencyUnavailable => {
            return self.request(
                allocator,
                bot,
                method,
            );
        },
    };

    select.concurrent(.timeout, struct {
        fn run(args: struct { io: std.Io, timeout: i32 }) void {
            std.Io.sleep(
                args.io,
                std.Io.Duration.fromSeconds(args.timeout),
                .awake,
            ) catch {};
        }
    }.run, .{.{ .io = io, .timeout = timeout }}) catch |err| switch (err) {
        error.ConcurrencyUnavailable => {
            select.cancelDiscard();
            return self.request(
                allocator,
                bot,
                method,
            );
        },
    };

    const result = try select.await();
    while (select.cancel()) |_| {}

    return switch (result) {
        .timeout => {
            return error.Timeout;
        },
        .request => |r| r,
    };
}

pub fn request(
    self: *ClientSession,
    allocator: std.mem.Allocator,
    bot: Bot,
    method: anytype,
) !@TypeOf(method).Result {
    const Method = @TypeOf(method);

    var arena = std.heap.ArenaAllocator.init(self.allocator);
    defer arena.deinit();

    const url_str = try self.options.api.apiUrl(arena.allocator(), bot.token, Method.method_name);

    var has_files = false;
    inline for (std.meta.fields(Method)) |field| {
        if (field.type == InputFile or field.type == ?InputFile) {
            has_files = true;
            break;
        }
    }

    const boundary = "----ZiogramBoundary42";
    const content_type: []const u8 = if (has_files)
        "multipart/form-data; boundary=----ZiogramBoundary42"
    else
        "application/json";

    var payload_aw = std.Io.Writer.Allocating.init(arena.allocator());
    defer payload_aw.deinit();

    if (has_files) {
        try self.writeMultipart(&payload_aw.writer, method, boundary);
    } else {
        var jws = std.json.Stringify{
            .writer = &payload_aw.writer,
            .options = .{ .emit_null_optional_fields = false },
        };
        var files_map = FilesMap.empty;
        try self.base.prepareValue(arena.allocator(), self.io, &jws, method, &files_map);
    }

    const payload_data = payload_aw.written();

    var response_aw = std.Io.Writer.Allocating.init(arena.allocator());
    defer response_aw.deinit();

    const result = self.base.client.fetch(.{
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

    const response = try self.base.checkResponse(
        allocator,
        method,
        result.status,
        response_aw.written(),
    );

    return response.result orelse error.TelegramBadRequest;
}

pub fn streamContent(
    self: *ClientSession,
    url: []const u8,
    writer: *std.Io.Writer,
) !void {
    const uri = try std.Uri.parse(url);

    var req = try self.base.client.request(.GET, uri, .{
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
