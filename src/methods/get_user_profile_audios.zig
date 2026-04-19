const types = @import("types");

pub const ReturnType = types.UserProfileAudios;
pub const api_method = "getUserProfileAudios";

user_id: i64,
offset: ?i32 = null,
limit: ?i32 = null,
