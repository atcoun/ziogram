const enums = @import("enums");
const types = @import("types");

pub const Result = bool;
pub const method_name = "setStickerSetThumbnail";

name: []const u8,
user_id: i64,
format: enums.StickerFormat,
thumbnail: ?types.InputFile = null,
