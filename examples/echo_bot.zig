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

pub fn main(init: std.process.Init) !void {
    const allocator = init.gpa;
    const io = init.io;

    // var api = try TelegramAPI.init(allocator, "http://127.0.0.1:8081", true, .{});
    // defer api.deinit(allocator);

    var session = try ClientSession.init(allocator, io, .{}); // .{ .api = api }
    defer session.deinit();

    var bot = try Bot.init("YOUR_BOT_TOKEN", &session);
    defer bot.deinit();

    {
        const arena = init.arena;
        _ = try bot.deleteWebhook(arena, .{ .drop_pending_updates = true });
        const me = try bot.getMe(arena, .{});
        if (me.username) |username| std.log.info("Authorized as @{s}", .{username});
    }

    var group: std.Io.Group = .init;
    defer group.cancel(io);

    var offset: i32 = 0;
    while (true) {
        var arena = std.heap.ArenaAllocator.init(allocator);

        const updates = bot.getUpdates(&arena, .{
            .offset = offset,
            .timeout = 50,
            .allowed_updates = &.{
                .message,
            },
        }) catch |err| {
            arena.deinit();
            std.log.warn("Network error in getUpdates: {any}. Retrying in 1 seconds...", .{err});
            try io.sleep(std.Io.Duration.fromSeconds(1), .awake);
            continue;
        };

        if (updates.len == 0) {
            arena.deinit();
            continue;
        }

        for (updates) |update| {
            group.concurrent(io, handleUpdate, .{ &arena, bot, update }) catch |err| switch (err) {
                error.ConcurrencyUnavailable => {
                    handleUpdate(&arena, bot, update) catch |e|
                        std.log.err("handleUpdate: {any}", .{e});
                },
            };
        }

        group.await(io) catch {};

        offset = updates[updates.len - 1].update_id + 1;

        arena.deinit();
    }
}

pub fn handleUpdate(arena: *std.heap.ArenaAllocator, bot: Bot, update: Update) !void {
    const message = update.message orelse return;
    if (message.chat.type != enums.ChatType.private) return;

    handleMessage(arena, bot, message) catch |err| {
        std.log.err("Error [handleMessage]: {any}", .{err});
    };
}

pub fn handleMessage(arena: *std.heap.ArenaAllocator, bot: Bot, message: Message) !void {
    const message_text = message.text orelse return;

    const text = if (std.mem.eql(u8, message_text, "/start"))
        try std.fmt.allocPrint(arena.allocator(), "Hello, {s}!", .{message.from.?.first_name})
    else
        message_text;

    _ = try bot.sendMessage(arena, .{
        .chat_id = .{ .id = message.chat.id },
        .text = text,
    });
}
