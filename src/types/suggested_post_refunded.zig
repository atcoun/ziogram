const enums = @import("../enums.zig");
const types = @import("../types.zig");

pub const SuggestedPostRefunded = struct {
    suggested_post_message: ?*types.Message = null,
    reason: enums.RefundReason,
};
