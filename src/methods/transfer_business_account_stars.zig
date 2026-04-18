pub const TransferBusinessAccountStars = struct {
    business_connection_id: []const u8,
    star_count: i32,

    pub const ReturnType = bool;
    pub const api_method = "transferBusinessAccountStars";
};
