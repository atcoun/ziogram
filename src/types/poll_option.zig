const types = @import("types");

persistent_id: []const u8,
text: []const u8,
text_entities: ?[]const types.MessageEntity = null,
media: ?types.PollMedia = null,
voter_count: i32,
added_by_user: ?types.User = null,
added_by_chat: ?types.Chat = null,
addition_date: ?i32 = null,
