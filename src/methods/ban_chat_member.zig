const types = @import("types");

pub const Result = bool;
pub const method_name = "banChatMember";

chat_id: types.ChatId,
user_id: i64,
until_date: ?i32 = null,
revoke_messages: ?bool = null,
