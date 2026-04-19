const enums = @import("enums");
const types = @import("../types.zig");

type: enums.InlineQueryResultType = .voice,
id: []const u8,
voice_url: []const u8,
title: []const u8,
caption: ?[]const u8 = null,
parse_mode: ?enums.ParseMode = null,
caption_entities: ?[]const types.MessageEntity = null,
voice_duration: ?i32 = null,
reply_markup: ?types.InlineKeyboardMarkup = null,
input_message_content: ?types.InputMessageContent = null,
