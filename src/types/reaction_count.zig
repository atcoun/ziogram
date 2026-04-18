const types = @import("../types.zig");

pub const ReactionCount = struct {
    type: types.ReactionType,
    total_count: i32,
};
