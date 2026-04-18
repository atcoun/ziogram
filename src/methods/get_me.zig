const types = @import("../types.zig");

pub const GetMe = struct {
    pub const ReturnType = types.User;
    pub const api_method = "getMe";
};
