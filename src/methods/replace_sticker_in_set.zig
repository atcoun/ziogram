const types = @import("types");

pub const ReturnType = bool;
pub const api_method = "replaceStickerInSet";

user_id: i64,
name: []const u8,
old_sticker: []const u8,
sticker: types.InputSticker,
