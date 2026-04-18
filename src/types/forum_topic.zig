pub const ForumTopic = struct {
    message_thread_id: i32,
    name: []const u8,
    icon_color: i32,
    icon_custom_emoji_id: ?[]const u8 = null,
    is_name_implicit: ?bool = null,
};
