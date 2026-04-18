const types = @import("../types.zig");

pub const SuggestedPostParameters = struct {
    price: ?types.SuggestedPostPrice = null,
    send_date: ?i32 = null,
};
