const enums = @import("enums");
const types = @import("../types.zig");

name: []const u8,
sticker: types.Sticker,
rarity_per_mille: i32,
rarity: ?enums.GiftRarity = null,
