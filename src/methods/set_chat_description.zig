const types = @import("../types.zig");

pub const SetChatDescription = struct {
    chat_id: types.ChatId,
    description: ?[]const u8 = null,

    pub const ReturnType = bool;
    pub const api_method = "setChatDescription";
};
