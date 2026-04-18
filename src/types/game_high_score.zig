const types = @import("../types.zig");

pub const GameHighScore = struct {
    position: i32,
    user: types.User,
    score: i32,
};
