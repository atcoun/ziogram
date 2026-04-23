const types = @import("types");

pub const Result = bool;
pub const method_name = "answerInlineQuery";

inline_query_id: []const u8,
results: []const types.InlineQueryResult,
cache_time: ?i32 = null,
is_personal: ?bool = null,
next_offset: ?[]const u8 = null,
button: ?types.InlineQueryResultsButton = null,
