const types = @import("types");

pub const Result = types.UserProfileAudios;
pub const method_name = "getUserProfileAudios";

user_id: i64,
offset: ?i32 = null,
limit: ?i32 = null,
