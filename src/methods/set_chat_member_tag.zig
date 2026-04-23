const types = @import("types");

pub const Result = bool;
pub const method_name = "setChatMemberTag";

chat_id: types.ChatId,
user_id: i64,
tag: ?[]const u8 = null,
