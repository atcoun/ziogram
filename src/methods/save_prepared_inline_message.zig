const types = @import("types");

pub const ReturnType = types.PreparedInlineMessage;
pub const api_method = "savePreparedInlineMessage";

user_id: i64,
result: types.InlineQueryResult,
allow_user_chats: ?bool = null,
allow_bot_chats: ?bool = null,
allow_group_chats: ?bool = null,
allow_channel_chats: ?bool = null,
