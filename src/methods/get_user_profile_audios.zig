const types = @import("../types.zig");

pub const GetUserProfileAudios = struct {
    user_id: i64,
    offset: ?i32 = null,
    limit: ?i32 = null,

    pub const ReturnType = types.UserProfileAudios;
    pub const api_method = "getUserProfileAudios";
};
