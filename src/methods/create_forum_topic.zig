const types = @import("../types.zig");

pub const CreateForumTopic = struct {
    chat_id: types.ChatId,
    name: []const u8,
    icon_color: ?i32 = null,
    icon_custom_emoji_id: ?[]const u8 = null,

    pub const ReturnType = types.ForumTopic;
    pub const api_method = "createForumTopic";
};
