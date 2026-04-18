const types = @import("../types.zig");

pub const DeleteForumTopic = struct {
    chat_id: types.ChatId,
    message_thread_id: i32,

    pub const ReturnType = bool;
    pub const api_method = "deleteForumTopic";
};
