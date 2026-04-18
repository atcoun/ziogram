const enums = @import("../enums.zig");
const types = @import("../types.zig");

pub const UniqueGiftInfo = struct {
    gift: types.UniqueGift,
    origin: enums.UniqueGiftOrigin,
    last_resale_currency: ?[]const u8 = null,
    last_resale_amount: ?i32 = null,
    owned_gift_id: ?[]const u8 = null,
    transfer_star_count: ?i32 = null,
    next_transfer_date: ?i32 = null,
};
