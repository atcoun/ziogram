const types = @import("types");

pub const Result = types.OwnedGifts;
pub const method_name = "getUserGifts";

user_id: i64,
exclude_unlimited: ?bool = null,
exclude_limited_upgradable: ?bool = null,
exclude_limited_non_upgradable: ?bool = null,
exclude_from_blockchain: ?bool = null,
exclude_unique: ?bool = null,
sort_by_price: ?bool = null,
offset: ?[]const u8 = null,
limit: ?i32 = null,
