const enums = @import("enums");
const types = @import("types");

pub const ReturnType = types.File;
pub const api_method = "uploadStickerFile";

user_id: i64,
sticker: types.InputFile,
sticker_format: enums.InputStickerFormat,
