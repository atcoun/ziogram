const enums = @import("../enums.zig");
const types = @import("../types.zig");

pub const InlineQueryResultGame = struct {
    type: enums.InlineQueryResultType = .game,
    id: []const u8,
    game_short_name: []const u8,
    reply_markup: ?types.InlineKeyboardMarkup = null,
};
