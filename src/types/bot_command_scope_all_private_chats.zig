const enums = @import("../enums.zig");

pub const BotCommandScopeAllPrivateChats = struct {
    type: enums.BotCommandScopeType = .all_private_chats,
};
