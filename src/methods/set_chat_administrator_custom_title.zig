const types = @import("types");

pub const ReturnType = bool;
pub const api_method = "setChatAdministratorCustomTitle";

chat_id: types.ChatId,
user_id: i64,
custom_title: []const u8,
