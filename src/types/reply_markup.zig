const types = @import("types");

pub const ReplyMarkup = union(enum) {
    inline_keyboard_markup: types.InlineKeyboardMarkup,
    reply_keyboard_markup: types.ReplyKeyboardMarkup,
    reply_keyboard_remove: types.ReplyKeyboardRemove,
    force_reply: types.ForceReply,

    pub fn jsonStringify(self: @This(), jws: anytype) !void {
        return switch (self) {
            inline else => |payload| try jws.write(payload),
        };
    }
};
