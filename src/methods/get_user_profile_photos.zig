const types = @import("types");

pub const ReturnType = types.UserProfilePhotos;
pub const api_method = "getUserProfilePhotos";

user_id: i64,
offset: ?i32 = null,
limit: ?i32 = null,
