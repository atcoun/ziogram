const types = @import("../types.zig");

pub const GetUserChatBoosts = struct {
    chat_id: types.ChatId,
    user_id: i32,

    pub const ReturnType = types.UserChatBoosts;
    pub const api_method = "getUserChatBoosts";
};
