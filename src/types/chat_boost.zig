const types = @import("../types.zig");

pub const ChatBoost = struct {
    boost_id: []const u8,
    add_date: i32,
    expiration_date: i32,
    source: types.ChatBoostSource,
};
