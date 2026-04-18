const types = @import("../types.zig");

pub const UniqueGiftBackdrop = struct {
    name: []const u8,
    colors: types.UniqueGiftBackdropColors,
    rarity_per_mille: i32,
};
