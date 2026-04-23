const types = @import("types");

pub const Result = types.SentWebAppMessage;
pub const method_name = "answerWebAppQuery";

web_app_query_id: []const u8,
result: types.InlineQueryResult,
