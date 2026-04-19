const types = @import("types");

pub const ReturnType = bool;
pub const api_method = "setStickerMaskPosition";

sticker: []const u8,
mask_position: ?types.MaskPosition = null,
