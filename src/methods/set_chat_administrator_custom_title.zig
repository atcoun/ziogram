const types = @import("../types.zig");

pub const SetChatAdministratorCustomTitle = struct {
    chat_id: types.ChatId,
    user_id: i32,
    custom_title: []const u8,

    pub const ReturnType = bool;
    pub const api_method = "setChatAdministratorCustomTitle";
};
