const types = @import("../types.zig");

pub const GetMyCommands = struct {
    scope: ?types.BotCommandScope = null,
    language_code: ?[]const u8 = null,

    pub const ReturnType = []const types.BotCommand;
    pub const api_method = "getMyCommands";
};
