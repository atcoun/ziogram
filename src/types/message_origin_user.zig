const enums = @import("../enums.zig");
const types = @import("../types.zig");

pub const MessageOriginUser = struct {
    type: enums.MessageOriginType = .user,
    date: i32,
    sender_user: types.User,
};
