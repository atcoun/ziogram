const enums = @import("../enums.zig");
const types = @import("../types.zig");

pub const SuggestedPostPaid = struct {
    suggested_post_message: ?*types.Message = null,
    currency: enums.Currency,
    amount: ?i32 = null,
    star_amount: ?types.StarAmount = null,
};
