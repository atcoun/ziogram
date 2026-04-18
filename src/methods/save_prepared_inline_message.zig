const types = @import("../types.zig");

pub const SavePreparedInlineMessage = struct {
    user_id: i32,
    result: types.InlineQueryResult,
    allow_user_chats: ?bool = null,
    allow_bot_chats: ?bool = null,
    allow_group_chats: ?bool = null,
    allow_channel_chats: ?bool = null,

    pub const ReturnType = types.PreparedInlineMessage;
    pub const api_method = "savePreparedInlineMessage";
};
