const types = @import("types");

pub const ReturnType = types.Message;
pub const api_method = "editMessageChecklist";

business_connection_id: []const u8,
chat_id: i64,
message_id: i32,
checklist: types.InputChecklist,
reply_markup: ?types.InlineKeyboardMarkup = null,
