const types = @import("../types.zig");

pub const BanChatSenderChat = struct {
    chat_id: types.ChatId,
    sender_chat_id: i32,

    pub const ReturnType = bool;
    pub const api_method = "banChatSenderChat";
};
