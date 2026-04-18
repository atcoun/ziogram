const types = @import("../types.zig");

pub const GiftInfo = struct {
    gift: types.Gift,
    owned_gift_id: ?[]const u8 = null,
    convert_star_count: ?i32 = null,
    prepaid_upgrade_star_count: ?i32 = null,
    is_upgrade_separate: ?bool = null,
    can_be_upgraded: ?bool = null,
    text: ?[]const u8 = null,
    entities: ?[]const types.MessageEntity = null,
    is_private: ?bool = null,
    unique_gift_number: ?i32 = null,
};
