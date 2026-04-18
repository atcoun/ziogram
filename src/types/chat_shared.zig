const types = @import("../types.zig");

pub const ChatShared = struct {
    request_id: i32,
    chat_id: i64,
    title: ?[]const u8 = null,
    username: ?[]const u8 = null,
    photo: ?[]const types.PhotoSize = null,
};
