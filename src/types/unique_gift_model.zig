const enums = @import("../enums.zig");
const types = @import("../types.zig");

pub const UniqueGiftModel = struct {
    name: []const u8,
    sticker: types.Sticker,
    rarity_per_mille: i32,
    rarity: ?enums.GiftRarity = null,
};
