const enums = @import("enums");
const types = @import("types");

pub const ReturnType = bool;
pub const api_method = "setStickerSetThumbnail";

name: []const u8,
user_id: i64,
format: enums.StickerFormat,
thumbnail: ?types.InputFile = null,
