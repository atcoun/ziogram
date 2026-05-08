const types = @import("types");

pub const Result = []const types.Message;
pub const method_name = "getUserPersonalChatMessages";

user_id: i64,
limit: i32,
