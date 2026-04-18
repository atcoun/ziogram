const enums = @import("../enums.zig");
const types = @import("../types.zig");

pub const CreateNewStickerSet = struct {
    user_id: i64,
    name: []const u8,
    title: []const u8,
    stickers: []const types.InputSticker,
    sticker_type: ?enums.StickerType = null,
    needs_repainting: ?bool = null,
};
