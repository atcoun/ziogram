const types = @import("types");

pub const Result = types.UserProfilePhotos;
pub const method_name = "getUserProfilePhotos";

user_id: i64,
offset: ?i32 = null,
limit: ?i32 = null,
