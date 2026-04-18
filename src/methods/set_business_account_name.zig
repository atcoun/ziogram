pub const SetBusinessAccountName = struct {
    business_connection_id: []const u8,
    first_name: []const u8,
    last_name: ?[]const u8 = null,

    pub const ReturnType = bool;
    pub const api_method = "setBusinessAccountName";
};
