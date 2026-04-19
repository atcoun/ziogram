const enums = @import("enums");
const types = @import("types");

type: enums.OwnedGiftKind = .unique,
gift: types.UniqueGift,
owned_gift_id: ?[]const u8 = null,
sender_user: ?types.User = null,
send_date: i32,
is_saved: ?bool = null,
can_be_transferred: ?bool = null,
transfer_star_count: ?i32 = null,
next_transfer_date: ?i32 = null,
