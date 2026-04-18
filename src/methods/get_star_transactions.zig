const types = @import("../types.zig");

pub const GetStarTransactions = struct {
    offset: ?i32 = null,
    limit: ?i32 = null,

    pub const ReturnType = types.StarTransactions;
    pub const api_method = "getStarTransactions";
};
