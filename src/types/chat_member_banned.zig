const types = @import("../types.zig");

pub const ChatMemberBanned = struct {
    status: []const u8 = "kicked",
    user: types.User,
    until_date: i32,
};
