const types = @import("../types.zig");

pub const UniqueGift = struct {
    gift_id: []const u8,
    base_name: []const u8,
    name: []const u8,
    number: i32,
    model: types.UniqueGiftModel,
    symbol: types.UniqueGiftSymbol,
    backdrop: types.UniqueGiftBackdrop,
    is_premium: ?bool = null,
    is_burned: ?bool = null,
    is_from_blockchain: ?bool = null,
    colors: ?types.UniqueGiftColors = null,
    publisher_chat: ?types.Chat = null,
};
