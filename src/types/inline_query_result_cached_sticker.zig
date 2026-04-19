const enums = @import("enums");
const types = @import("types");

type: enums.InlineQueryResultType = .sticker,
id: []const u8,
sticker_file_id: []const u8,
reply_markup: ?types.InlineKeyboardMarkup = null,
input_message_content: ?types.InputMessageContent = null,
