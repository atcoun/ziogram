const enums = @import("../enums.zig");
const types = @import("../types.zig");

pub const SuggestedPostInfo = struct {
    state: enums.SuggestedPostState,
    price: ?types.SuggestedPostPrice = null,
    send_date: ?i32 = null,
};
