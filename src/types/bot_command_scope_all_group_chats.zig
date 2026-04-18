const enums = @import("../enums.zig");

pub const BotCommandScopeAllGroupChats = struct {
    type: enums.BotCommandScopeType = .all_group_chats,
};
