const std = @import("std");

const ziogram = @import("ziogram");
const ClientSession = ziogram.ClientSession;
const Bot = ziogram.Bot;
// const TelegramAPI = ziogram.TelegramAPI;

const enums = ziogram.enums;
const ChatType = enums.ChatType;

const types = ziogram.types;
const Update = types.Update;
const Message = types.Message;

const web_server_host = "127.0.0.1";
const web_server_port = 8080;
const webhook_path = "/webhook";
const webhook_secret = "YOUR_SECRET_TOKEN";
const webhook_url = "https://example.com"; // Local Bot API: optionally use your local HTTP URL, e.g. "http://127.0.0.1:8080"

pub fn main(init: std.process.Init) !void {
    const arena = init.arena;
    const allocator = init.gpa;
    const io = init.io;

    // var api = try TelegramAPI.init(allocator, "http://127.0.0.1:8081", true, .{});
    // defer api.deinit(allocator);

    var session = try ClientSession.init(allocator, io, .{}); // .{ .api = api }
    defer session.deinit();

    var bot = try Bot.init("YOUR_BOT_TOKEN", &session);
    defer bot.deinit();

    _ = bot.setWebhook(arena, .{
        .url = try std.fmt.allocPrint(
            arena.allocator(),
            "{s}{s}",
            .{ webhook_url, webhook_path },
        ),
        .drop_pending_updates = true,
        .secret_token = webhook_secret,
    }) catch |err| {
        std.log.err("Failed to set webhook: {any}", .{err});
        return err;
    };

    const me = try bot.getMe(arena, .{});
    if (me.username) |username| std.log.info("Authorized as @{s}", .{username});

    try startWebhook(allocator, io, bot, web_server_port);
}

pub fn startWebhook(allocator: std.mem.Allocator, io: std.Io, bot: Bot, port: u16) !void {
    const addr = try std.Io.net.IpAddress.parseIp4(web_server_host, port);
    var server = try addr.listen(io, .{});
    defer server.deinit(io);

    var group: std.Io.Group = .init;
    defer group.cancel(io);

    while (true) {
        const stream = try server.accept(io);
        group.concurrent(io, handleConn, .{ allocator, io, bot, &group, stream }) catch |err| switch (err) {
            error.ConcurrencyUnavailable => {
                handleConn(allocator, io, bot, &group, stream) catch |e|
                    std.log.err("handleConn: {any}", .{e});
            },
        };
    }
}

fn handleConn(allocator: std.mem.Allocator, io: std.Io, bot: Bot, group: *std.Io.Group, stream: std.Io.net.Stream) !void {
    defer stream.close(io);

    var read_buf: [8192]u8 = undefined;
    var net_reader = stream.reader(io, &read_buf);

    var write_buf: [4096]u8 = undefined;
    var net_writer = stream.writer(io, &write_buf);

    var http = std.http.Server.init(&net_reader.interface, &net_writer.interface);

    while (true) {
        var req = http.receiveHead() catch break;
        handleRequest(allocator, io, bot, group, &req) catch break;
        if (!req.head.keep_alive) break;
    }
}

fn handleRequest(allocator: std.mem.Allocator, io: std.Io, bot: Bot, group: *std.Io.Group, req: *std.http.Server.Request) !void {
    if (req.head.method != .POST or !std.mem.eql(u8, req.head.target, webhook_path)) {
        try req.respond("Not Found", .{ .status = .not_found });
        return;
    }

    var secret_token: ?[]const u8 = null;
    var it = req.iterateHeaders();
    while (it.next()) |header| {
        if (std.ascii.eqlIgnoreCase(header.name, "x-telegram-bot-api-secret-token")) {
            secret_token = header.value;
            break;
        }
    }

    const secret = secret_token orelse {
        try req.respond("Forbidden", .{ .status = .forbidden });
        return;
    };
    if (!std.mem.eql(u8, secret, webhook_secret)) {
        try req.respond("Forbidden", .{ .status = .forbidden });
        return;
    }

    var body_buf: [65536]u8 = undefined;
    const body_reader = try req.readerExpectContinue(&body_buf);
    const n = try body_reader.readSliceShort(&body_buf);
    const body = body_buf[0..n];

    try req.respond("", .{ .status = .ok });

    const arena = try allocator.create(std.heap.ArenaAllocator);
    arena.* = std.heap.ArenaAllocator.init(allocator);

    const update = std.json.parseFromSliceLeaky(
        Update,
        arena.allocator(),
        body,
        .{
            .ignore_unknown_fields = true,
            .allocate = .alloc_always,
        },
    ) catch |err| {
        std.log.err("json parse: {any}", .{err});
        return;
    };

    group.concurrent(io, handleUpdate, .{ arena, bot, update }) catch |err| switch (err) {
        error.ConcurrencyUnavailable => {
            handleUpdate(arena, bot, update) catch |e|
                std.log.err("handleUpdate: {any}", .{e});
        },
    };
}

pub fn handleUpdate(arena: *std.heap.ArenaAllocator, bot: Bot, update: Update) !void {
    defer {
        arena.deinit();
        arena.child_allocator.destroy(arena);
    }
    if (update.message) |message| {
        if (message.chat.type == ChatType.private) {
            handleMessage(arena, bot, message) catch |err| {
                std.log.err("Error [handleMessage]: {any}", .{err});
            };
        }
    }
}

pub fn handleMessage(arena: *std.heap.ArenaAllocator, bot: Bot, message: Message) !void {
    if (message.text) |text| {
        if (std.mem.eql(u8, text, "/start")) {
            _ = try bot.sendMessage(arena, .{
                .chat_id = .{ .id = message.chat.id },
                .text = try std.fmt.allocPrint(
                    arena.allocator(),
                    "Hello, {s}!",
                    .{message.from.?.first_name},
                ),
            });
        } else {
            _ = try bot.sendMessage(arena, .{
                .chat_id = .{ .id = message.chat.id },
                .text = text,
            });
        }
    }
}
