const types = @import("types");

pub const Result = bool;
pub const method_name = "setManagedBotAccessSettings";

user_id: i64,
is_access_restricted: bool,
added_user_ids: ?[]const i64 = null,
