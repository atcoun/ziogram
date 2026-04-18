const types = @import("../types.zig");

pub const BanChatMember = struct {
    chat_id: types.ChatId,
    user_id: i64,
    until_date: ?i32 = null,
    revoke_messages: ?bool = null,

    pub const ReturnType = bool;
    pub const api_method = "banChatMember";
};
