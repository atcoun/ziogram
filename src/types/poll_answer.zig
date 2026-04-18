const types = @import("../types.zig");

pub const PollAnswer = struct {
    poll_id: []const u8,
    voter_chat: ?types.Chat = null,
    user: ?types.User = null,
    option_ids: []const i32,
    option_persistent_ids: []const []const u8,
};
