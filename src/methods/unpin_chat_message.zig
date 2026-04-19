const types = @import("types");

pub const ReturnType = bool;
pub const api_method = "unpinChatMessage";

chat_id: types.ChatId,
business_connection_id: ?[]const u8 = null,
message_id: ?i32 = null,
