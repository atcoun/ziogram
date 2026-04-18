const enums = @import("../enums.zig");
const types = @import("../types.zig");

pub const SetStickerSetThumbnail = struct {
    name: []const u8,
    user_id: i32,
    format: enums.StickerFormat,
    thumbnail: ?types.InputFile = null,

    pub const ReturnType = bool;
    pub const api_method = "setStickerSetThumbnail";
};
