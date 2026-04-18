const types = @import("../types.zig");

pub const ChatLocation = struct {
    location: types.Location,
    address: []const u8,
};
