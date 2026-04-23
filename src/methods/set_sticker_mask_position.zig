const types = @import("types");

pub const Result = bool;
pub const method_name = "setStickerMaskPosition";

sticker: []const u8,
mask_position: ?types.MaskPosition = null,
