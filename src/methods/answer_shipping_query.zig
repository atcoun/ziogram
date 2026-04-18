const types = @import("../types.zig");

pub const AnswerShippingQuery = struct {
    shipping_query_id: []const u8,
    ok: bool,
    shipping_options: ?[]const types.ShippingOption = null,
    error_message: ?[]const u8 = null,

    pub const ReturnType = bool;
    pub const api_method = "answerShippingQuery";
};
