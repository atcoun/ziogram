const enums = @import("../enums.zig");
const types = @import("../types.zig");

pub const InputMediaPhoto = struct {
    type: enums.InputMediaType = .photo,
    media: []const u8,
    caption: ?[]const u8 = null,
    parse_mode: ?enums.ParseMode = null,
    caption_entities: ?[]const types.MessageEntity = null,
    show_caption_above_media: ?bool = null,
    has_spoiler: ?bool = null,
};
