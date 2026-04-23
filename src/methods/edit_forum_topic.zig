const types = @import("types");

pub const Result = bool;
pub const method_name = "editForumTopic";

chat_id: types.ChatId,
message_thread_id: i32,
name: ?[]const u8 = null,
icon_custom_emoji_id: ?[]const u8 = null,
