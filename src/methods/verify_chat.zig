const types = @import("../types.zig");

pub const VerifyChat = struct {
    chat_id: types.ChatId,
    custom_description: ?[]const u8 = null,

    pub const ReturnType = bool;
    pub const api_method = "verifyChat";
};
