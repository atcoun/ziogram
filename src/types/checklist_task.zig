const types = @import("../types.zig");

pub const ChecklistTask = struct {
    id: i32,
    text: []const u8,
    text_entities: ?[]const types.MessageEntity = null,
    completed_by_user: ?types.User = null,
    completed_by_chat: ?types.Chat = null,
    completion_date: ?i32 = null,
};
