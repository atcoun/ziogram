const types = @import("../types.zig");

invite_link: []const u8,
creator: types.User,
creates_join_request: bool,
is_primary: bool,
is_revoked: bool,
name: ?[]const u8 = null,
expire_date: ?i32 = null,
member_limit: ?i32 = null,
pending_join_request_count: ?i32 = null,
subscription_period: ?i32 = null,
subscription_price: ?i32 = null,
