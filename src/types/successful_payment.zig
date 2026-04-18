const types = @import("../types.zig");

pub const SuccessfulPayment = struct {
    currency: []const u8,
    total_amount: i32,
    invoice_payload: []const u8,
    subscription_expiration_date: ?i32 = null,
    is_recurring: ?bool = null,
    is_first_recurring: ?bool = null,
    shipping_option_id: ?[]const u8 = null,
    order_info: ?types.OrderInfo = null,
    telegram_payment_charge_id: []const u8,
    provider_payment_charge_id: []const u8,
};
