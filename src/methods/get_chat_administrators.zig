const types = @import("../types.zig");

pub const GetChatAdministrators = struct {
    chat_id: types.ChatId,

    pub const ReturnType = []const types.ChatMember;
    pub const api_method = "getChatAdministrators";
};
