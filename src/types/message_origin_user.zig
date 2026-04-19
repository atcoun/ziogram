const enums = @import("enums");
const types = @import("../types.zig");

type: enums.MessageOriginType = .user,
date: i32,
sender_user: types.User,
