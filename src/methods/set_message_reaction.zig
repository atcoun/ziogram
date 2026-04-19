const types = @import("types");

pub const ReturnType = bool;
pub const api_method = "setMessageReaction";

chat_id: types.ChatId,
message_id: i32,
reaction: ?[]const types.ReactionType = null,
is_big: ?bool = null,
