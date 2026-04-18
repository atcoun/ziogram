const types = @import("../types.zig");

pub const EditForumTopic = struct {
    chat_id: types.ChatId,
    message_thread_id: i32,
    name: ?[]const u8 = null,
    icon_custom_emoji_id: ?[]const u8 = null,

    pub const ReturnType = bool;
    pub const api_method = "editForumTopic";
};
