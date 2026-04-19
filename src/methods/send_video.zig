const enums = @import("enums");
const types = @import("types");

pub const ReturnType = types.Message;
pub const api_method = "sendVideo";

chat_id: types.ChatId,
video: types.InputFile,
business_connection_id: ?[]const u8 = null,
message_thread_id: ?i32 = null,
direct_messages_topic_id: ?i32 = null,
duration: ?i32 = null,
width: ?i32 = null,
height: ?i32 = null,
thumbnail: ?types.InputFile = null,
cover: ?types.InputFile = null,
start_timestamp: ?i32 = null,
caption: ?[]const u8 = null,
parse_mode: ?enums.ParseMode = null,
caption_entities: ?[]const types.MessageEntity = null,
show_caption_above_media: ?bool = null,
has_spoiler: ?bool = null,
supports_streaming: ?bool = null,
disable_notification: ?bool = null,
protect_content: ?bool = null,
allow_paid_broadcast: ?bool = null,
message_effect_id: ?[]const u8 = null,
suggested_post_parameters: ?types.SuggestedPostParameters = null,
reply_parameters: ?types.ReplyParameters = null,
reply_markup: ?types.ReplyMarkup = null,
