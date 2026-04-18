const types = @import("../types.zig");

pub const PaidMediaPurchased = struct {
    from: types.User,
    paid_media_payload: []const u8,
};
