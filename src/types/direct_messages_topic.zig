const types = @import("../types.zig");

pub const DirectMessagesTopic = struct {
    topic_id: i64,
    user: ?types.User = null,
};
