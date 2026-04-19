const enums = @import("enums");
const types = @import("../types.zig");

type: enums.InlineQueryResultType = .gif,
id: []const u8,
gif_url: []const u8,
gif_width: ?i32 = null,
gif_height: ?i32 = null,
gif_duration: ?i32 = null,
thumbnail_url: []const u8,
thumbnail_mime_type: ?[]const u8 = null,
title: ?[]const u8 = null,
caption: ?[]const u8 = null,
parse_mode: ?enums.ParseMode = null,
caption_entities: ?[]const types.MessageEntity = null,
show_caption_above_media: ?bool = null,
reply_markup: ?types.InlineKeyboardMarkup = null,
input_message_content: ?types.InputMessageContent = null,
