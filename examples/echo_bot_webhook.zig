const std = @import("std");
const ziogram = @import("ziogram");

const Io = std.Io;

const Client = ziogram.Client;
const Bot = ziogram.Bot;

const enums = ziogram.enums;
const ChatType = enums.ChatType;

const types = ziogram.types;
const Message = types.Message;
const Update = types.Update;

const web_server_host = "127.0.0.1";
const web_server_port = 8080;
const webhook_path = "/webhook";
const webhook_secret = "YOUR_SECRET_TOKEN";
const webhook_url = "https://example.com";

pub fn main(init: std.process.Init) !void {
    const arena = init.arena;
    const gpa = init.gpa;
    const io = init.io;

    const token = "YOUR_BOT_TOKEN";

    const client = try Client.init(gpa, init.io, .{});
    defer client.deinit();

    const bot = try Bot.init(token, client, .{});
    defer bot.deinit();

    const allocator = arena.allocator();

    _ = bot.setWebhook(allocator, .{
        .url = try std.fmt.allocPrint(
            allocator,
            "{s}{s}",
            .{ webhook_url, webhook_path },
        ),
        .drop_pending_updates = true,
        .secret_token = webhook_secret,
    }) catch |err| {
        std.log.err("Failed to set webhook: {any}", .{err});
        return err;
    };

    try startWebhook(io, gpa, bot, web_server_port);
}

pub fn startWebhook(io: Io, gpa: std.mem.Allocator, bot: Bot, port: u16) !void {
    const addr = try Io.net.IpAddress.parseIp4(web_server_host, port);
    var server = try addr.listen(io, .{});
    defer server.deinit(io);

    const me = try bot.getMe(gpa, .{});
    if (me.username) |username| std.log.info("Authorized as @{s}", .{username});
    std.log.info("\n🌟 Enjoying ziogram? Support the project with a star: https://github.com/atcoun/ziogram", .{});

    var group = Io.Group.init;
    defer group.await(io) catch {};

    while (true) {
        const stream = try server.accept(io);
        try group.concurrent(io, handleConn, .{ gpa, io, bot, &group, stream });
    }
}

fn handleConn(gpa: std.mem.Allocator, io: Io, bot: Bot, group: *Io.Group, stream: Io.net.Stream) !void {
    defer stream.close(io);

    var read_buf: [8192]u8 = undefined;
    var write_buf: [4096]u8 = undefined;

    var net_reader = stream.reader(io, &read_buf);
    var net_writer = stream.writer(io, &write_buf);

    var http = std.http.Server.init(&net_reader.interface, &net_writer.interface);

    while (true) {
        var req = http.receiveHead() catch break;
        handleRequest(gpa, io, bot, group, &req) catch break;
        if (!req.head.keep_alive) break;
    }
}

fn handleRequest(gpa: std.mem.Allocator, io: Io, bot: Bot, group: *Io.Group, req: *std.http.Server.Request) !void {
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

    const parsed = std.json.parseFromSlice(
        Update,
        gpa,
        body,
        .{ .ignore_unknown_fields = true },
    ) catch |err| {
        std.log.err("json parse: {any}", .{err});
        return;
    };

    group.async(io, handleUpdate, .{ gpa, bot, parsed.value, parsed });
}

pub fn handleUpdate(gpa: std.mem.Allocator, bot: Bot, update: Update, parsed: std.json.Parsed(Update)) !void {
    defer parsed.deinit();

    var arena = std.heap.ArenaAllocator.init(gpa);
    defer arena.deinit();

    const allocator = arena.allocator();

    if (update.message) |message| {
        if (message.chat.type == enums.ChatType.private) {
            handleMessage(allocator, bot, message) catch |err| {
                std.log.err("Error [handleMessage]: {any}", .{err});
            };
        }
    }
}

pub fn handleMessage(allocator: std.mem.Allocator, bot: Bot, message: Message) !void {
    if (message.text) |text| {
        if (std.mem.eql(u8, text, "/start")) {
            _ = try bot.sendMessage(allocator, .{
                .chat_id = .{ .id = message.chat.id },
                .text = try std.fmt.allocPrint(
                    allocator,
                    "Hello, {s}!",
                    .{message.from.?.first_name},
                ),
            });
        }
    }
}
