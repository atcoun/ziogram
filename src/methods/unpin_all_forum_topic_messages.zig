const types = @import("../types.zig");

pub const UnpinAllForumTopicMessages = struct {
    chat_id: types.ChatId,
    message_thread_id: i32,

    pub const ReturnType = bool;
    pub const api_method = "unpinAllForumTopicMessages";
};
