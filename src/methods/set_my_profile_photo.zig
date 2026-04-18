const types = @import("../types.zig");

pub const SetMyProfilePhoto = struct {
    photo: types.InputProfilePhoto,

    pub const ReturnType = bool;
    pub const api_method = "setMyProfilePhoto";
};
