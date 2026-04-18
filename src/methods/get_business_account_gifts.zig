const types = @import("../types.zig");

pub const GetBusinessAccountGifts = struct {
    business_connection_id: []const u8,
    exclude_unsaved: ?bool = null,
    exclude_saved: ?bool = null,
    exclude_unlimited: ?bool = null,
    exclude_limited_upgradable: ?bool = null,
    exclude_limited_non_upgradable: ?bool = null,
    exclude_unique: ?bool = null,
    exclude_from_blockchain: ?bool = null,
    sort_by_price: ?bool = null,
    offset: ?[]const u8 = null,
    limit: ?i32 = null,

    pub const ReturnType = types.OwnedGifts;
    pub const api_method = "getBusinessAccountGifts";
};
