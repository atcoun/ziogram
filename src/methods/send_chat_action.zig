const enums = @import("enums");
const types = @import("types");

pub const ReturnType = bool;
pub const api_method = "sendChatAction";

chat_id: types.ChatId,
action: enums.ChatAction,
business_connection_id: ?[]const u8 = null,
message_thread_id: ?i32 = null,
