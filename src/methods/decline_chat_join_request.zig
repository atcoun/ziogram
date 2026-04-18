const types = @import("../types.zig");

pub const DeclineChatJoinRequest = struct {
    chat_id: types.ChatId,
    user_id: i32,

    pub const ReturnType = bool;
    pub const api_method = "declineChatJoinRequest";
};
