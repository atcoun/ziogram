const enums = @import("../enums.zig");
const types = @import("../types.zig");

pub const OwnedGiftRegular = struct {
    type: enums.OwnedGiftKind = .regular,
    gift: types.Gift,
    owned_gift_id: ?[]const u8 = null,
    sender_user: ?types.User = null,
    send_date: i32,
    text: ?[]const u8 = null,
    entities: ?[]const types.MessageEntity = null,
    is_private: ?bool = null,
    is_saved: ?bool = null,
    can_be_upgraded: ?bool = null,
    was_refunded: ?bool = null,
    convert_star_count: ?i32 = null,
    prepaid_upgrade_star_count: ?i32 = null,
    is_upgrade_separate: ?bool = null,
    unique_gift_number: ?i32 = null,
};
