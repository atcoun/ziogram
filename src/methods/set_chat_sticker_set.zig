const types = @import("types");

pub const Result = bool;
pub const method_name = "setChatStickerSet";

chat_id: types.ChatId,
sticker_set_name: []const u8,
