const enums = @import("enums");
const types = @import("types");

pub const Result = bool;
pub const method_name = "editEphemeralMessageCaption";

chat_id: types.ChatId,
receiver_user_id: i64,
ephemeral_message_id: i64,
caption: ?[]const u8 = null,
parse_mode: ?enums.ParseMode = null,
caption_entities: ?[]const types.MessageEntity = null,
reply_markup: ?types.InlineKeyboardMarkup = null,
