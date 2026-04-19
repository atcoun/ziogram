const types = @import("types");

chat: types.Chat,
message_id: i32,
user: ?types.User = null,
actor_chat: ?types.Chat = null,
date: i32,
old_reaction: []const types.ReactionType,
new_reaction: []const types.ReactionType,
