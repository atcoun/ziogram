const types = @import("../types.zig");

pub const OwnedGifts = struct {
    total_count: i32,
    gifts: []const types.OwnedGift,
    next_offset: ?[]const u8 = null,
};
