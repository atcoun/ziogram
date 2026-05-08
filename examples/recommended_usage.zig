const std = @import("std");
const ziogram = @import("ziogram");

// Define shared options once at the top of your file
const parse_mode = .HTML;
// const disable_notification = true;
// const protect_content = true;
// ...

pub fn main(init: std.process.Init) !void {
    var client = try ziogram.Client.init(init.gpa, init.io, .{});
    defer client.deinit();

    var bot = try ziogram.Bot.init("YOUR_BOT_TOKEN", client);
    defer bot.deinit();

    const allocator = init.arena.allocator();

    // Use the shared parse_mode constant
    _ = try bot.sendMessage(allocator, .{
        .chat_id = .{ .id = 123456789 },
        .text = "Message with <b>bold</b> and <u>underline</u>",
        .parse_mode = parse_mode,
    });

    // Without parse_mode (default)
    _ = try bot.sendMessage(allocator, .{
        .chat_id = .{ .id = 123456789 },
        .text = "Message without <b>bold</b> formatting",
    });
}
