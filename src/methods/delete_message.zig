const types = @import("../types.zig");

pub const DeleteMessage = struct {
    chat_id: types.ChatId,
    message_id: i32,

    pub const ReturnType = bool;
    pub const api_method = "deleteMessage";
};
