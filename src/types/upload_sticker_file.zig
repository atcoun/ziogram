const enums = @import("../enums.zig");
const types = @import("../types.zig");

pub const UploadStickerFile = struct {
    user_id: i64,
    sticker: types.InputFile,
    sticker_format: enums.InputStickerFormat,
};
