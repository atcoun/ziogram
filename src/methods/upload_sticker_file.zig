const enums = @import("../enums.zig");
const types = @import("../types.zig");

pub const UploadStickerFile = struct {
    user_id: i32,
    sticker: types.InputFile,
    sticker_format: enums.InputStickerFormat,

    pub const ReturnType = types.File;
    pub const api_method = "uploadStickerFile";
};
