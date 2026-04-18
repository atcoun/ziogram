const types = @import("../types.zig");

pub const SetStickerMaskPosition = struct {
    sticker: []const u8,
    mask_position: ?types.MaskPosition = null,
};
