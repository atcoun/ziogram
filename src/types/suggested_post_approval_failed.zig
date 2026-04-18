const types = @import("../types.zig");

pub const SuggestedPostApprovalFailed = struct {
    suggested_post_message: ?*types.Message = null,
    price: types.SuggestedPostPrice,
};
