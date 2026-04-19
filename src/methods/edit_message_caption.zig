const enums = @import("enums");
const types = @import("types");

pub const ReturnType = types.MessageOrBool;
pub const api_method = "editMessageCaption";

business_connection_id: ?[]const u8 = null,
chat_id: ?types.ChatId = null,
message_id: ?i32 = null,
inline_message_id: ?[]const u8 = null,
caption: ?[]const u8 = null,
parse_mode: ?enums.ParseMode = null,
caption_entities: ?[]const types.MessageEntity = null,
show_caption_above_media: ?bool = null,
reply_markup: ?types.InlineKeyboardMarkup = null,
