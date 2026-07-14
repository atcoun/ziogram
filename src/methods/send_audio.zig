const enums = @import("enums");
const types = @import("types");

pub const Result = types.Message;
pub const method_name = "sendAudio";

chat_id: types.ChatId,
audio: types.InputFile,
business_connection_id: ?[]const u8 = null,
message_thread_id: ?i32 = null,
direct_messages_topic_id: ?i32 = null,
receiver_user_id: ?i32 = null,
callback_query_id: ?[]const u8 = null,
caption: ?[]const u8 = null,
parse_mode: ?enums.ParseMode = null,
caption_entities: ?[]const types.MessageEntity = null,
duration: ?i32 = null,
performer: ?[]const u8 = null,
title: ?[]const u8 = null,
thumbnail: ?types.InputFile = null,
disable_notification: ?bool = null,
protect_content: ?bool = null,
allow_paid_broadcast: ?bool = null,
message_effect_id: ?[]const u8 = null,
suggested_post_parameters: ?types.SuggestedPostParameters = null,
reply_parameters: ?types.ReplyParameters = null,
reply_markup: ?types.ReplyMarkup = null,
