const types = @import("../types.zig");

status: []const u8 = "creator",
user: types.User,
is_anonymous: bool,
custom_title: ?[]const u8 = null,
