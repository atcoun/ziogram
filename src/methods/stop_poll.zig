const types = @import("types");

pub const ReturnType = types.Poll;
pub const api_method = "stopPoll";

chat_id: types.ChatId,
message_id: i32,
business_connection_id: ?[]const u8 = null,
reply_markup: ?types.InlineKeyboardMarkup = null,
