const enums = @import("../enums.zig");

pub const MessageOriginHiddenUser = struct {
    type: enums.MessageOriginType = .hidden_user,
    date: i32,
    sender_user_name: []const u8,
};
