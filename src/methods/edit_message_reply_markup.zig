const types = @import("types");

pub const ReturnType = types.MessageOrBool;
pub const api_method = "editMessageReplyMarkup";

business_connection_id: ?[]const u8 = null,
chat_id: ?types.ChatId = null,
message_id: ?i32 = null,
inline_message_id: ?[]const u8 = null,
reply_markup: ?types.InlineKeyboardMarkup = null,
