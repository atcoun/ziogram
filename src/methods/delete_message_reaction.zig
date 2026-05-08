const types = @import("types");

pub const Result = bool;
pub const method_name = "deleteMessageReaction";

chat_id: types.ChatId,
message_id: i32,
user_id: ?i64 = null,
actor_chat_id: ?i64 = null,
