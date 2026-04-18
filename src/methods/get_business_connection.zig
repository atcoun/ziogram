const types = @import("../types.zig");

pub const GetBusinessConnection = struct {
    business_connection_id: []const u8,

    pub const ReturnType = types.BusinessConnection;
    pub const api_method = "getBusinessConnection";
};
