const types = @import("../types.zig");

pub const GetChatMemberCount = struct {
    chat_id: types.ChatId,

    pub const ReturnType = i32;
    pub const api_method = "getChatMemberCount";
};
