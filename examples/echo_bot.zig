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

pub fn main(init: std.process.Init) !void {
    const arena = init.arena;
    const gpa = init.gpa;
    const io = init.io;

    const token = "YOUR_BOT_TOKEN";

    const client = try Client.init(gpa, init.io, .{});
    defer client.deinit();

    const bot = try Bot.init(token, client, .{});
    defer bot.deinit();

    {
        const allocator = arena.allocator();
        _ = try bot.deleteWebhook(allocator, .{ .drop_pending_updates = true });
        const me = try bot.getMe(allocator, .{});
        if (me.username) |username| std.log.info("Authorized as @{s}", .{username});
        std.log.info("🌟 Enjoying ziogram? Support the project with a star: https://github.com/atcoun/ziogram", .{});
    }

    var group: Io.Group = .init;
    defer group.cancel(io);

    var offset: i32 = 0;

    while (true) {
        const allocator = arena.allocator();

        const updates = bot.getUpdates(allocator, .{
            .offset = offset,
            .timeout = 60,
            .allowed_updates = &.{
                .message,
            },
        }) catch |err| {
            std.log.warn("Network error in getUpdates: {any}. Retrying in 10 seconds...", .{err});
            const delay = Io.Duration.fromSeconds(10);
            try io.sleep(delay, .awake);
            continue;
        };

        for (updates) |update| {
            group.concurrent(io, handleUpdate, .{ gpa, bot, update }) catch |err| switch (err) {
                error.ConcurrencyUnavailable => {
                    handleUpdate(gpa, bot, update) catch |e|
                        std.log.err("handleUpdate: {any}", .{e});
                },
            };
            offset = update.update_id + 1;
        }

        group.await(io) catch {};
        _ = arena.reset(.retain_capacity);
    }
}

pub fn handleUpdate(gpa: std.mem.Allocator, bot: Bot, update: Update) !void {
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
