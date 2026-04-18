const types = @import("../types.zig");

pub const InlineKeyboardMarkup = struct {
    inline_keyboard: []const []const types.InlineKeyboardButton,
};
