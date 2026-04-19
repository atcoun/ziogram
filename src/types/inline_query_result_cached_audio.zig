const enums = @import("enums");
const types = @import("types");

type: enums.InlineQueryResultType = .audio,
id: []const u8,
audio_file_id: []const u8,
caption: ?[]const u8 = null,
parse_mode: ?enums.ParseMode = null,
caption_entities: ?[]const types.MessageEntity = null,
reply_markup: ?types.InlineKeyboardMarkup = null,
input_message_content: ?types.InputMessageContent = null,
