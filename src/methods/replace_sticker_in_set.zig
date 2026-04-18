const types = @import("../types.zig");

pub const ReplaceStickerInSet = struct {
    user_id: i32,
    name: []const u8,
    old_sticker: []const u8,
    sticker: types.InputSticker,

    pub const ReturnType = bool;
    pub const api_method = "replaceStickerInSet";
};
