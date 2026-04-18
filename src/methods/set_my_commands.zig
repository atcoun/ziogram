const types = @import("../types.zig");

pub const SetMyCommands = struct {
    commands: []const types.BotCommand,
    scope: ?types.BotCommandScope = null,
    language_code: ?[]const u8 = null,

    pub const ReturnType = bool;
    pub const api_method = "setMyCommands";
};
