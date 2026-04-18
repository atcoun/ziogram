const types = @import("../types.zig");

pub const VideoChatParticipantsInvited = struct {
    users: []const types.User,
};
