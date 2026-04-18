const types = @import("../types.zig");

pub const SetChatMemberTag = struct {
    chat_id: types.ChatId,
    user_id: i32,
    tag: ?[]const u8 = null,

    pub const ReturnType = bool;
    pub const api_method = "setChatMemberTag";
};
