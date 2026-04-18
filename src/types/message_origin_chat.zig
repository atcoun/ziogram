const enums = @import("../enums.zig");
const types = @import("../types.zig");

pub const MessageOriginChat = struct {
    type: enums.MessageOriginType = .chat,
    date: i32,
    sender_chat: types.Chat,
    author_signature: ?[]const u8 = null,
};
