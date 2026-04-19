const types = @import("../types.zig");

id: []const u8,
user: types.User,
user_chat_id: i64,
date: i32,
rights: ?types.BusinessBotRights = null,
is_enabled: bool,
