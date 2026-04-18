const types = @import("../types.zig");

pub const SetStickerMaskPosition = struct {
    sticker: []const u8,
    mask_position: ?types.MaskPosition = null,

    pub const ReturnType = bool;
    pub const api_method = "setStickerMaskPosition";
};
