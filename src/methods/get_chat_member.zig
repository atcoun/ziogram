const types = @import("types");

pub const Result = types.ChatMember;
pub const method_name = "getChatMember";

chat_id: types.ChatId,
user_id: i64,
