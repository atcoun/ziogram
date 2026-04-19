const types = @import("types");

pub const ReturnType = bool;
pub const api_method = "deleteMessages";

chat_id: types.ChatId,
message_ids: []const i32,
