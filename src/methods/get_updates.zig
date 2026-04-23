const enums = @import("enums");
const types = @import("types");

pub const Result = []types.Update;
pub const method_name = "getUpdates";

offset: ?i32 = null,
limit: ?i32 = null,
timeout: ?i32 = null,
allowed_updates: ?[]const enums.UpdateType = null,
