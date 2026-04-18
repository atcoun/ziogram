const types = @import("../types.zig");

pub const GetBusinessAccountStarBalance = struct {
    business_connection_id: []const u8,

    pub const ReturnType = types.StarAmount;
    pub const api_method = "getBusinessAccountStarBalance";
};
