const types = @import("types");

pub const Result = types.UserChatBoosts;
pub const method_name = "getUserChatBoosts";

chat_id: types.ChatId,
user_id: i64,
