const types = @import("types");

pub const Result = []const types.MessageId;
pub const method_name = "forwardMessages";

chat_id: types.ChatId,
from_chat_id: types.ChatId,
message_ids: []const i32,
message_thread_id: ?i32 = null,
direct_messages_topic_id: ?i32 = null,
disable_notification: ?bool = null,
protect_content: ?bool = null,
