pub const ReturnType = bool;
pub const api_method = "answerPreCheckoutQuery";

pre_checkout_query_id: []const u8,
ok: bool,
error_message: ?[]const u8 = null,
