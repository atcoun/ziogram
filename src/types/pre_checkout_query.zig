const types = @import("../types.zig");

pub const PreCheckoutQuery = struct {
    id: []const u8,
    from: types.User,
    currency: []const u8,
    total_amount: i32,
    invoice_payload: []const u8,
    shipping_option_id: ?[]const u8 = null,
    order_info: ?types.OrderInfo = null,
};
