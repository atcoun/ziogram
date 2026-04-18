const types = @import("../types.zig");

pub const AnswerWebAppQuery = struct {
    web_app_query_id: []const u8,
    result: types.InlineQueryResult,

    pub const ReturnType = types.SentWebAppMessage;
    pub const api_method = "answerWebAppQuery";
};
