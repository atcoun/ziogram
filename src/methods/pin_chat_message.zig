const types = @import("types");

pub const Result = bool;
pub const method_name = "pinChatMessage";

chat_id: types.ChatId,
message_id: i32,
business_connection_id: ?[]const u8 = null,
disable_notification: ?bool = null,
