const types = @import("../types.zig");

pub const GetMyStarBalance = struct {
    pub const ReturnType = types.StarAmount;
    pub const api_method = "getMyStarBalance";
};
