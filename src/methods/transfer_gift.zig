pub const TransferGift = struct {
    business_connection_id: []const u8,
    owned_gift_id: []const u8,
    new_owner_chat_id: i32,
    star_count: ?i32 = null,

    pub const ReturnType = bool;
    pub const api_method = "transferGift";
};
