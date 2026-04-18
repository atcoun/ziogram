const enums = @import("../enums.zig");
const types = @import("../types.zig");

pub const InputMediaAnimation = struct {
    type: enums.InputMediaType = .animation,
    media: []const u8,
    thumbnail: ?[]const u8 = null,
    caption: ?[]const u8 = null,
    parse_mode: ?enums.ParseMode = null,
    caption_entities: ?[]const types.MessageEntity = null,
    show_caption_above_media: ?bool = null,
    width: ?i32 = null,
    height: ?i32 = null,
    duration: ?i32 = null,
    has_spoiler: ?bool = null,
};
