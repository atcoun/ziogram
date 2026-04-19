const enums = @import("enums");
const types = @import("types");

pub const ReturnType = []types.Update;
pub const api_method = "getUpdates";

offset: ?i32 = null,
limit: ?i32 = null,
timeout: ?i32 = null,
allowed_updates: ?[]const enums.UpdateType = null,
