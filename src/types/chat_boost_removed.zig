const types = @import("../types.zig");

pub const ChatBoostRemoved = struct {
    chat: types.Chat,
    boost_id: []const u8,
    remove_date: i32,
    source: types.ChatBoostSource,
};
