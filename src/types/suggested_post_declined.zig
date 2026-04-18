const types = @import("../types.zig");

pub const SuggestedPostDeclined = struct {
    suggested_post_message: ?*types.Message = null,
    comment: ?[]const u8 = null,
};
