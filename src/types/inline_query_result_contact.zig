const enums = @import("enums");
const types = @import("types");

type: enums.InlineQueryResultType = .contact,
id: []const u8,
phone_number: []const u8,
first_name: []const u8,
last_name: ?[]const u8 = null,
vcard: ?[]const u8 = null,
reply_markup: ?types.InlineKeyboardMarkup = null,
input_message_content: ?types.InputMessageContent = null,
thumbnail_url: ?[]const u8 = null,
thumbnail_width: ?i32 = null,
thumbnail_height: ?i32 = null,
