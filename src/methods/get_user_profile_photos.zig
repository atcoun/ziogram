const types = @import("../types.zig");

pub const GetUserProfilePhotos = struct {
    user_id: i64,
    offset: ?i32 = null,
    limit: ?i32 = null,

    pub const ReturnType = types.UserProfilePhotos;
    pub const api_method = "getUserProfilePhotos";
};
