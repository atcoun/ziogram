const enums = @import("../enums.zig");
const types = @import("../types.zig");

pub const StickerSet = struct {
    name: []const u8,
    title: []const u8,
    sticker_type: enums.StickerType,
    stickers: []const types.Sticker,
    thumbnail: ?types.PhotoSize = null,
};
