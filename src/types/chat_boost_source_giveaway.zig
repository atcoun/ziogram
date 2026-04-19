const enums = @import("enums");
const types = @import("../types.zig");

source: enums.ChatBoostSourceType = .giveaway,
giveaway_message_id: i32,
user: ?types.User = null,
prize_star_count: ?i32 = null,
is_unclaimed: ?bool = null,
