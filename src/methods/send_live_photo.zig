const enums = @import("enums");
const types = @import("types");

pub const Result = types.Message;
pub const method_name = "sendLivePhoto";

business_connection_id: ?[]const u8 = null,
chat_id: types.ChatId,
message_thread_id: ?i32 = null,
direct_messages_topic_id: ?i32 = null,
live_photo: types.InputFile,
photo: types.InputFile,
caption: ?[]const u8 = null,
parse_mode: ?enums.ParseMode = null,
caption_entities: ?[]const types.MessageEntity = null,
show_caption_above_media: ?bool = null,
has_spoiler: ?bool = null,
disable_notification: ?bool = null,
protect_content: ?bool = null,
allow_paid_broadcast: ?bool = null,
message_effect_id: ?[]const u8 = null,
suggested_post_parameters: ?types.SuggestedPostParameters = null,
reply_parameters: ?types.ReplyParameters = null,
reply_markup: ?types.ReplyMarkup = null,
