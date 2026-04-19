const types = @import("types");

pub const ReturnType = bool;
pub const api_method = "setMyCommands";

commands: []const types.BotCommand,
scope: ?types.BotCommandScope = null,
language_code: ?[]const u8 = null,
