const enums = @import("enums");
const types = @import("types");

type: enums.InlineQueryResultType = .article,
id: []const u8,
title: []const u8,
input_message_content: types.InputMessageContent,
reply_markup: ?types.InlineKeyboardMarkup = null,
url: ?[]const u8 = null,
description: ?[]const u8 = null,
thumbnail_url: ?[]const u8 = null,
thumbnail_width: ?i32 = null,
thumbnail_height: ?i32 = null,
