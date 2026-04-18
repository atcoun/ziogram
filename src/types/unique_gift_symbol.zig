const types = @import("../types.zig");

pub const UniqueGiftSymbol = struct {
    name: []const u8,
    sticker: types.Sticker,
    rarity_per_mille: i32,
};
