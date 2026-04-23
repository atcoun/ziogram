const types = @import("types");

pub const Result = bool;
pub const method_name = "addStickerToSet";

user_id: i64,
name: []const u8,
sticker: types.InputSticker,
