const enums = @import("../enums.zig");
const types = @import("../types.zig");

pub const BotCommandScopeChatAdministrators = struct {
    type: enums.BotCommandScopeType = .chat_administrators,
    chat_id: types.ChatId,
};
