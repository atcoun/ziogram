const enums = @import("enums");
const types = @import("types");

pub const Result = bool;
pub const method_name = "editEphemeralMessageText";

chat_id: types.ChatId,
receiver_user_id: i64,
ephemeral_message_id: i32,
text: []const u8,
parse_mode: ?enums.ParseMode = null,
entities: ?[]const types.MessageEntity = null,
link_preview_options: ?types.LinkPreviewOptions = null,
reply_markup: ?types.InlineKeyboardMarkup = null,
