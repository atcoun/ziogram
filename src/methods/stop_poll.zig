const types = @import("types");

pub const Result = types.Poll;
pub const method_name = "stopPoll";

chat_id: types.ChatId,
message_id: i32,
business_connection_id: ?[]const u8 = null,
reply_markup: ?types.InlineKeyboardMarkup = null,
