const types = @import("../types.zig");

pub const GetMyShortDescription = struct {
    language_code: ?[]const u8 = null,

    pub const ReturnType = types.BotShortDescription;
    pub const api_method = "getMyShortDescription";
};
