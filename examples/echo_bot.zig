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
    const arena = init.arena;
    const allocator = init.gpa;
    const io = init.io;

    // var api = try TelegramAPI.init(allocator, "http://127.0.0.1:8081", true, .{});
    // defer api.deinit(allocator);

    var session = try ClientSession.init(allocator, io, .{}); // .{ .api = api }
    defer session.deinit();

    var bot = try Bot.init("YOUR_BOT_TOKEN", &session);
    defer bot.deinit();

    _ = try bot.deleteWebhook(arena, .{ .drop_pending_updates = true });
    const me = try bot.getMe(arena, .{});
    if (me.username) |username| std.log.info("Authorized as @{s}", .{username});

    var group: std.Io.Group = .init;
    defer group.cancel(io);

    var offset: i32 = 0;

    while (true) {
        const updates = bot.getUpdates(arena, .{
            .offset = offset,
            .timeout = 50,
            .allowed_updates = &.{
                .message,
            },
        }) catch |err| {
            std.log.warn("Network error in getUpdates: {any}. Retrying in 1 seconds...", .{err});
            const delay = std.Io.Duration.fromSeconds(1);
            try io.sleep(delay, .awake);
            continue;
        };

        if (updates.len == 0) continue;

        for (updates) |update| {
            group.concurrent(io, handleUpdate, .{ arena, bot, update }) catch |err| switch (err) {
                error.ConcurrencyUnavailable => {
                    handleUpdate(arena, bot, update) catch |e|
                        std.log.err("handleUpdate: {any}", .{e});
                },
            };
        }

        group.await(io) catch {};

        if (updates.len > 0) {
            offset = updates[updates.len - 1].update_id + 1;
        }

        _ = arena.reset(.retain_capacity);
    }
}

pub fn handleUpdate(arena: *std.heap.ArenaAllocator, bot: Bot, update: Update) !void {
    if (update.message) |message| {
        if (message.chat.type == enums.ChatType.private) {
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
