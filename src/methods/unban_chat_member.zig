const types = @import("types");

pub const Result = bool;
pub const method_name = "unbanChatMember";

chat_id: types.ChatId,
user_id: i64,
only_if_banned: ?bool = null,
