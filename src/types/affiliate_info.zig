const types = @import("../types.zig");

affiliate_user: ?types.User = null,
affiliate_chat: ?types.Chat = null,
commission_per_mille: i32,
amount: i32,
nanostar_amount: ?i32 = null,
