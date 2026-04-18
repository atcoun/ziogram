const types = @import("../types.zig");

pub const GetMyName = struct {
    language_code: ?[]const u8 = null,

    pub const ReturnType = types.BotName;
    pub const api_method = "getMyName";
};
