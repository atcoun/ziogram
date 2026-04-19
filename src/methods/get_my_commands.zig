const types = @import("types");

pub const ReturnType = []const types.BotCommand;
pub const api_method = "getMyCommands";

scope: ?types.BotCommandScope = null,
language_code: ?[]const u8 = null,
