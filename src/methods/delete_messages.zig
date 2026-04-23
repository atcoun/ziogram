const types = @import("types");

pub const Result = bool;
pub const method_name = "deleteMessages";

chat_id: types.ChatId,
message_ids: []const i32,
