const types = @import("types");

pub const Result = types.Message;
pub const method_name = "sendChecklist";

business_connection_id: []const u8,
chat_id: types.ChatId,
checklist: types.InputChecklist,
disable_notification: ?bool = null,
protect_content: ?bool = null,
message_effect_id: ?[]const u8 = null,
reply_parameters: ?types.ReplyParameters = null,
reply_markup: ?types.InlineKeyboardMarkup = null,
