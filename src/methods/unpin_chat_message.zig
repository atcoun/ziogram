const types = @import("../types.zig");

pub const UnpinChatMessage = struct {
    chat_id: types.ChatId,
    business_connection_id: ?[]const u8 = null,
    message_id: ?i32 = null,

    pub const ReturnType = bool;
    pub const api_method = "unpinChatMessage";
};
