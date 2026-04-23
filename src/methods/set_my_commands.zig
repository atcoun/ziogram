const types = @import("types");

pub const Result = bool;
pub const method_name = "setMyCommands";

commands: []const types.BotCommand,
scope: ?types.BotCommandScope = null,
language_code: ?[]const u8 = null,
