const enums = @import("../enums.zig");
const types = @import("../types.zig");

pub const SendChatAction = struct {
    chat_id: types.ChatId,
    action: enums.ChatAction,
    business_connection_id: ?[]const u8 = null,
    message_thread_id: ?i32 = null,

    pub const ReturnType = bool;
    pub const api_method = "sendChatAction";
};
