const types = @import("../types.zig");

pub const AddStickerToSet = struct {
    user_id: i32,
    name: []const u8,
    sticker: types.InputSticker,

    pub const ReturnType = bool;
    pub const api_method = "addStickerToSet";
};
