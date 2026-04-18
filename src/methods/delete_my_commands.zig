const types = @import("../types.zig");

pub const DeleteMyCommands = struct {
    scope: ?types.BotCommandScope = null,
    language_code: ?[]const u8 = null,

    pub const ReturnType = bool;
    pub const api_method = "deleteMyCommands";
};
