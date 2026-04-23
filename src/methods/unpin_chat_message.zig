const types = @import("types");

pub const Result = bool;
pub const method_name = "unpinChatMessage";

chat_id: types.ChatId,
business_connection_id: ?[]const u8 = null,
message_id: ?i32 = null,
