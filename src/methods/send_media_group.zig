const enums = @import("enums");
const types = @import("types");

pub const Result = []const types.Message;
pub const method_name = "sendMediaGroup";

chat_id: types.ChatId,
media: []const types.InputMedia,
business_connection_id: ?[]const u8 = null,
message_thread_id: ?i32 = null,
direct_messages_topic_id: ?i32 = null,
disable_notification: ?bool = null,
protect_content: ?bool = null,
allow_paid_broadcast: ?bool = null,
message_effect_id: ?[]const u8 = null,
reply_parameters: ?types.ReplyParameters = null,
