const types = @import("../types.zig");

pub const UnbanChatMember = struct {
    chat_id: types.ChatId,
    user_id: i64,
    only_if_banned: ?bool = null,

    pub const ReturnType = bool;
    pub const api_method = "unbanChatMember";
};
