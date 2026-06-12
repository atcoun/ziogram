const enums = @import("enums");
const types = @import("types");

pub const Result = types.MessageOrBool;
pub const method_name = "editMessageText";

text: []const u8,
business_connection_id: ?[]const u8 = null,
chat_id: ?types.ChatId = null,
message_id: ?i32 = null,
inline_message_id: ?[]const u8 = null,
parse_mode: ?enums.ParseMode = null,
entities: ?[]const types.MessageEntity = null,
link_preview_options: ?types.LinkPreviewOptions = null,
rich_message: ?types.InputRichMessage = null,
reply_markup: ?types.InlineKeyboardMarkup = null,
