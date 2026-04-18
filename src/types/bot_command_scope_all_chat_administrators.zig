const enums = @import("../enums.zig");

pub const BotCommandScopeAllChatAdministrators = struct {
    type: enums.BotCommandScopeType = .all_chat_administrators,
};
