const types = @import("types");

pub const Result = types.Message;
pub const method_name = "sendSticker";

chat_id: types.ChatId,
sticker: types.InputFile,
business_connection_id: ?[]const u8 = null,
message_thread_id: ?i32 = null,
direct_messages_topic_id: ?i32 = null,
receiver_user_id: ?i32 = null,
callback_query_id: ?[]const u8 = null,
emoji: ?[]const u8 = null,
disable_notification: ?bool = null,
protect_content: ?bool = null,
allow_paid_broadcast: ?bool = null,
message_effect_id: ?[]const u8 = null,
suggested_post_parameters: ?types.SuggestedPostParameters = null,
reply_parameters: ?types.ReplyParameters = null,
reply_markup: ?types.ReplyMarkup = null,
