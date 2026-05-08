const types = @import("types");

pub const Result = bool;
pub const method_name = "deleteAllMessageReactions";

chat_id: types.ChatId,
user_id: ?i64 = null,
actor_chat_id: ?i64 = null,
