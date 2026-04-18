pub const RemoveBusinessAccountProfilePhoto = struct {
    business_connection_id: []const u8,
    is_public: ?bool = null,

    pub const ReturnType = bool;
    pub const api_method = "removeBusinessAccountProfilePhoto";
};
