const types = @import("../types.zig");

pub const BusinessLocation = struct {
    address: []const u8,
    location: ?types.Location = null,
};
