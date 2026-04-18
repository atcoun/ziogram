pub const SetBusinessAccountUsername = struct {
    business_connection_id: []const u8,
    username: ?[]const u8 = null,

    pub const ReturnType = bool;
    pub const api_method = "setBusinessAccountUsername";
};
