const types = @import("types");

pub const Result = types.SentGuestMessage;
pub const method_name = "answerGuestQuery";

guest_query_id: []const u8,
result: types.InlineQueryResult,
