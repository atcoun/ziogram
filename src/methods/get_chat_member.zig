const types = @import("types");

pub const ReturnType = types.ChatMember;
pub const api_method = "getChatMember";

chat_id: types.ChatId,
user_id: i64,
