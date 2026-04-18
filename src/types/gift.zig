const types = @import("../types.zig");

pub const Gift = struct {
    id: []const u8,
    sticker: types.Sticker,
    star_count: i32,
    upgrade_star_count: ?i32 = null,
    is_premium: ?bool = null,
    has_colors: ?bool = null,
    total_count: ?i32 = null,
    remaining_count: ?i32 = null,
    personal_total_count: ?i32 = null,
    personal_remaining_count: ?i32 = null,
    background: ?types.GiftBackground = null,
    unique_gift_variant_count: ?i32 = null,
    publisher_chat: ?types.Chat = null,
};
