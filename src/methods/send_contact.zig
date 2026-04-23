const types = @import("types");

pub const Result = types.Message;
pub const method_name = "sendContact";

chat_id: types.ChatId,
phone_number: []const u8,
first_name: []const u8,
business_connection_id: ?[]const u8 = null,
message_thread_id: ?i32 = null,
direct_messages_topic_id: ?i32 = null,
last_name: ?[]const u8 = null,
vcard: ?[]const u8 = null,
disable_notification: ?bool = null,
protect_content: ?bool = null,
allow_paid_broadcast: ?bool = null,
message_effect_id: ?[]const u8 = null,
suggested_post_parameters: ?types.SuggestedPostParameters = null,
reply_parameters: ?types.ReplyParameters = null,
reply_markup: ?types.ReplyMarkup = null,
