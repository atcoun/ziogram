const types = @import("../types.zig");

pub const SuggestedPostApproved = struct {
    suggested_post_message: ?*types.Message = null,
    price: ?types.SuggestedPostPrice = null,
    send_date: i32,
};
