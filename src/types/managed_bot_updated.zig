const types = @import("../types.zig");

pub const ManagedBotUpdated = struct {
    user: types.User,
    bot: types.User,
};
