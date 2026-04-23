pub const Result = bool;
pub const method_name = "answerCallbackQuery";

callback_query_id: []const u8,
text: ?[]const u8 = null,
show_alert: ?bool = null,
url: ?[]const u8 = null,
cache_time: ?i32 = null,
