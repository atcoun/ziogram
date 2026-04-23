const types = @import("types");

pub const Result = types.Message;
pub const method_name = "sendGame";

chat_id: i64,
game_short_name: []const u8,
business_connection_id: ?[]const u8 = null,
message_thread_id: ?i32 = null,
disable_notification: ?bool = null,
protect_content: ?bool = null,
allow_paid_broadcast: ?bool = null,
message_effect_id: ?[]const u8 = null,
reply_parameters: ?types.ReplyParameters = null,
reply_markup: ?types.InlineKeyboardMarkup = null,
