const enums = @import("enums");
const types = @import("../types.zig");

type: enums.InlineQueryResultType = .gif,
id: []const u8,
gif_file_id: []const u8,
title: ?[]const u8 = null,
caption: ?[]const u8 = null,
parse_mode: ?enums.ParseMode = null,
caption_entities: ?[]const types.MessageEntity = null,
show_caption_above_media: ?bool = null,
reply_markup: ?types.InlineKeyboardMarkup = null,
input_message_content: ?types.InputMessageContent = null,
