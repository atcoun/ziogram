const types = @import("../types.zig");

pub const AnswerInlineQuery = struct {
    inline_query_id: []const u8,
    results: []const types.InlineQueryResult,
    cache_time: ?i32 = null,
    is_personal: ?bool = null,
    next_offset: ?[]const u8 = null,
    button: ?types.InlineQueryResultsButton = null,

    pub const ReturnType = bool;
    pub const api_method = "answerInlineQuery";
};
