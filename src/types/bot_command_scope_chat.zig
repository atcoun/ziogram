const enums = @import("../enums.zig");
const types = @import("../types.zig");

pub const BotCommandScopeChat = struct {
    type: enums.BotCommandScopeType = .chat,
    chat_id: types.ChatId,
};
