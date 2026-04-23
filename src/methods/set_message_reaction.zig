const types = @import("types");

pub const Result = bool;
pub const method_name = "setMessageReaction";

chat_id: types.ChatId,
message_id: i32,
reaction: ?[]const types.ReactionType = null,
is_big: ?bool = null,
