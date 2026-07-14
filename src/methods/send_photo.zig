const enums = @import("enums");
const types = @import("types");

pub const Result = types.Message;
pub const method_name = "sendPhoto";

chat_id: types.ChatId,
photo: types.InputFile,
business_connection_id: ?[]const u8 = null,
message_thread_id: ?i32 = null,
direct_messages_topic_id: ?i32 = null,
receiver_user_id: ?i32 = null,
callback_query_id: ?[]const u8 = null,
caption: ?[]const u8 = null,
parse_mode: ?enums.ParseMode = null,
caption_entities: ?[]const types.MessageEntity = null,
show_caption_above_media: ?bool = null,
has_spoiler: ?bool = null,
disable_notification: ?bool = null,
protect_content: ?bool = null,
allow_paid_broadcast: ?bool = null,
message_effect_id: ?[]const u8 = null,
reply_parameters: ?types.ReplyParameters = null,
reply_markup: ?types.ReplyMarkup = null,
