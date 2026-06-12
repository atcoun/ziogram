const types = @import("types");

chat: types.Chat,
from: types.User,
user_chat_id: i64,
date: i32,
bio: ?[]const u8 = null,
invite_link: ?types.ChatInviteLink = null,
query_id: ?[]const u8 = null,
