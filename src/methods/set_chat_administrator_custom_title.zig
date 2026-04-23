const types = @import("types");

pub const Result = bool;
pub const method_name = "setChatAdministratorCustomTitle";

chat_id: types.ChatId,
user_id: i64,
custom_title: []const u8,
