pub const SetBusinessAccountBio = struct {
    business_connection_id: []const u8,
    bio: ?[]const u8 = null,

    pub const ReturnType = bool;
    pub const api_method = "setBusinessAccountBio";
};
