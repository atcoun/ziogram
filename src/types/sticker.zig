const enums = @import("../enums.zig");
const types = @import("../types.zig");

pub const Sticker = struct {
    file_id: []const u8,
    file_unique_id: []const u8,
    type: enums.StickerType,
    width: i32,
    height: i32,
    is_animated: bool,
    is_video: bool,
    thumbnail: ?types.PhotoSize = null,
    emoji: ?[]const u8 = null,
    set_name: ?[]const u8 = null,
    premium_animation: ?types.File = null,
    mask_position: ?types.MaskPosition = null,
    custom_emoji_id: ?[]const u8 = null,
    needs_repainting: ?bool = null,
    file_size: ?i32 = null,
};
