const types = @import("types");

pub const Result = types.ForumTopic;
pub const method_name = "createForumTopic";

chat_id: types.ChatId,
name: []const u8,
icon_color: ?i32 = null,
icon_custom_emoji_id: ?[]const u8 = null,
