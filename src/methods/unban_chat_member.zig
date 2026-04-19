const types = @import("types");

pub const ReturnType = bool;
pub const api_method = "unbanChatMember";

chat_id: types.ChatId,
user_id: i64,
only_if_banned: ?bool = null,
