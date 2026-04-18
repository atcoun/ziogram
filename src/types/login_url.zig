pub const LoginUrl = struct {
    url: []const u8,
    forward_text: ?[]const u8 = null,
    bot_username: ?[]const u8 = null,
    request_write_access: ?bool = null,
};
