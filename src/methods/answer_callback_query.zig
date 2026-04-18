pub const AnswerCallbackQuery = struct {
    callback_query_id: []const u8,
    text: ?[]const u8 = null,
    show_alert: ?bool = null,
    url: ?[]const u8 = null,
    cache_time: ?i32 = null,

    pub const ReturnType = bool;
    pub const api_method = "answerCallbackQuery";
};
