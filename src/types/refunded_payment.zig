pub const RefundedPayment = struct {
    currency: []const u8,
    total_amount: i32,
    invoice_payload: []const u8,
    telegram_payment_charge_id: []const u8,
    provider_payment_charge_id: ?[]const u8 = null,
};
