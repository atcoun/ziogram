const types = @import("../types.zig");

pub const SetMessageReaction = struct {
    chat_id: types.ChatId,
    message_id: i32,
    reaction: ?[]const types.ReactionType = null,
    is_big: ?bool = null,

    pub const ReturnType = bool;
    pub const api_method = "setMessageReaction";
};
