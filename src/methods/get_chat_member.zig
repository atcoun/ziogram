const types = @import("../types.zig");

pub const GetChatMember = struct {
    chat_id: types.ChatId,
    user_id: i32,

    pub const ReturnType = types.ChatMember;
    pub const api_method = "getChatMember";
};
