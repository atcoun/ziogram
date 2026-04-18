const types = @import("../types.zig");

pub const InaccessibleMessage = struct {
    chat: types.Chat,
    message_id: i32,
    date: i32 = 0,
};
