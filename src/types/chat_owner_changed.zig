const types = @import("../types.zig");

pub const ChatOwnerChanged = struct {
    new_owner: types.User,
};
