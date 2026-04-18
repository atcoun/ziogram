const types = @import("../types.zig");

pub const Game = struct {
    title: []const u8,
    description: []const u8,
    photo: []const types.PhotoSize,
    text: ?[]const u8 = null,
    text_entities: ?[]const types.MessageEntity = null,
    animation: ?types.Animation = null,
};
