const types = @import("types");

pub const Result = types.MessageOrBool;
pub const method_name = "editMessageLiveLocation";

latitude: f64,
longitude: f64,
business_connection_id: ?[]const u8 = null,
chat_id: ?types.ChatId = null,
message_id: ?i32 = null,
inline_message_id: ?[]const u8 = null,
live_period: ?i32 = null,
horizontal_accuracy: ?f64 = null,
heading: ?i32 = null,
proximity_alert_radius: ?i32 = null,
reply_markup: ?types.InlineKeyboardMarkup = null,
