const types = @import("../types.zig");

pub const UsersShared = struct {
    request_id: i32,
    users: []const types.SharedUser,
};
