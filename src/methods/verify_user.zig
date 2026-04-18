pub const VerifyUser = struct {
    user_id: i32,
    custom_description: ?[]const u8 = null,

    pub const ReturnType = bool;
    pub const api_method = "verifyUser";
};
