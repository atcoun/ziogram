const types = @import("../types.zig");

pub const ChatOwnerLeft = struct {
    new_owner: ?types.User = null,
};
