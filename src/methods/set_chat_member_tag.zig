const types = @import("types");

pub const ReturnType = bool;
pub const api_method = "setChatMemberTag";

chat_id: types.ChatId,
user_id: i64,
tag: ?[]const u8 = null,
