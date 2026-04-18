const types = @import("../types.zig");

pub const MessageReactionCountUpdated = struct {
    chat: types.Chat,
    message_id: i32,
    date: i32,
    reactions: []const types.ReactionCount,
};
