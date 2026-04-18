const types = @import("../types.zig");

pub const ChatMemberMember = struct {
    status: []const u8 = "member",
    tag: ?[]const u8 = null,
    user: types.User,
    until_date: ?i32 = null,
};
