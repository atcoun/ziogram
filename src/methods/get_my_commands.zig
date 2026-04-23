const types = @import("types");

pub const Result = []const types.BotCommand;
pub const method_name = "getMyCommands";

scope: ?types.BotCommandScope = null,
language_code: ?[]const u8 = null,
