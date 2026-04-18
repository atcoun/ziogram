const enums = @import("../enums.zig");
const types = @import("../types.zig");

pub const GetUpdates = struct {
    offset: ?i32 = null,
    limit: ?i32 = null,
    timeout: ?i32 = null,
    allowed_updates: ?[]const enums.UpdateType = null,

    pub const ReturnType = []types.Update;
    pub const api_method = "getUpdates";
};
