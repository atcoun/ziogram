const types = @import("../types.zig");

pub const SetChatTitle = struct {
    chat_id: types.ChatId,
    title: []const u8,

    pub const ReturnType = bool;
    pub const api_method = "setChatTitle";
};
