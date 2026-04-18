const enums = @import("../enums.zig");

pub const BotCommandScopeDefault = struct {
    type: enums.BotCommandScopeType = .default,
};
