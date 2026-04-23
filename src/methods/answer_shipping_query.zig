const types = @import("types");

pub const Result = bool;
pub const method_name = "answerShippingQuery";

shipping_query_id: []const u8,
ok: bool,
shipping_options: ?[]const types.ShippingOption = null,
error_message: ?[]const u8 = null,
