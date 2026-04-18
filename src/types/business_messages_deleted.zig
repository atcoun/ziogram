const types = @import("../types.zig");

pub const BusinessMessagesDeleted = struct {
    business_connection_id: []const u8,
    chat: types.Chat,
    message_ids: []const i32,
};
