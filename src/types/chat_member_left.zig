const types = @import("../types.zig");

pub const ChatMemberLeft = struct {
    status: []const u8 = "left",
    user: types.User,
};
