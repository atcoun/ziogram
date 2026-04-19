const enums = @import("enums");
const types = @import("../types.zig");

type: enums.InlineQueryResultType = .game,
id: []const u8,
game_short_name: []const u8,
reply_markup: ?types.InlineKeyboardMarkup = null,
