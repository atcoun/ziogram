const types = @import("types");

pub const ReturnType = bool;
pub const api_method = "setChatStickerSet";

chat_id: types.ChatId,
sticker_set_name: []const u8,
