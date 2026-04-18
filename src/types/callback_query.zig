const types = @import("../types.zig");

pub const CallbackQuery = struct {
    id: []const u8,
    from: types.User,
    message: ?types.MaybeInaccessibleMessage = null,
    inline_message_id: ?[]const u8 = null,
    chat_instance: []const u8,
    data: ?[]const u8 = null,
    game_short_name: ?[]const u8 = null,
};
