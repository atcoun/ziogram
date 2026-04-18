const types = @import("../types.zig");

pub const PinChatMessage = struct {
    chat_id: types.ChatId,
    message_id: i32,
    business_connection_id: ?[]const u8 = null,
    disable_notification: ?bool = null,

    pub const ReturnType = bool;
    pub const api_method = "pinChatMessage";
};
