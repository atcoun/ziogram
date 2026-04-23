pub const Result = bool;
pub const method_name = "transferGift";

business_connection_id: []const u8,
owned_gift_id: []const u8,
new_owner_chat_id: i64,
star_count: ?i32 = null,
