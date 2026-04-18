pub const GetManagedBotToken = struct {
    user_id: i32,

    pub const ReturnType = []const u8;
    pub const api_method = "getManagedBotToken";
};
