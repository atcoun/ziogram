const types = @import("../types.zig");

pub const ProximityAlertTriggered = struct {
    traveler: types.User,
    watcher: types.User,
    distance: i32,
};
