const enums = @import("../enums.zig");
const types = @import("../types.zig");

pub const InputMediaAudio = struct {
    type: enums.InputMediaType = .audio,
    media: []const u8,
    thumbnail: ?[]const u8 = null,
    caption: ?[]const u8 = null,
    parse_mode: ?enums.ParseMode = null,
    caption_entities: ?[]const types.MessageEntity = null,
    duration: ?i32 = null,
    performer: ?[]const u8 = null,
    title: ?[]const u8 = null,
};
