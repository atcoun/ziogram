pub const Result = bool;
pub const method_name = "upgradeGift";

business_connection_id: []const u8,
owned_gift_id: []const u8,
keep_original_details: ?bool = null,
star_count: ?i32 = null,
