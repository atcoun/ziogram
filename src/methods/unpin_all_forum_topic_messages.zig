const types = @import("types");

pub const ReturnType = bool;
pub const api_method = "unpinAllForumTopicMessages";

chat_id: types.ChatId,
message_thread_id: i32,
