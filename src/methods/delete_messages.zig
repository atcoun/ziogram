const types = @import("../types.zig");

pub const DeleteMessages = struct {
    chat_id: types.ChatId,
    message_ids: []const i32,

    pub const ReturnType = bool;
    pub const api_method = "deleteMessages";
};
