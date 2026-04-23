pub const Result = bool;
pub const method_name = "answerPreCheckoutQuery";

pre_checkout_query_id: []const u8,
ok: bool,
error_message: ?[]const u8 = null,
