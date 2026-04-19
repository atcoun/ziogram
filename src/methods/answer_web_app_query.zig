const types = @import("types");

pub const ReturnType = types.SentWebAppMessage;
pub const api_method = "answerWebAppQuery";

web_app_query_id: []const u8,
result: types.InlineQueryResult,
