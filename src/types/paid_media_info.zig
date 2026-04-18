const types = @import("../types.zig");

pub const PaidMediaInfo = struct {
    star_count: i32,
    paid_media: []const types.PaidMedia,
};
