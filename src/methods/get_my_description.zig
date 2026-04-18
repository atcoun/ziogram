const types = @import("../types.zig");

pub const GetMyDescription = struct {
    language_code: ?[]const u8 = null,

    pub const ReturnType = types.BotDescription;
    pub const api_method = "getMyDescription";
};
