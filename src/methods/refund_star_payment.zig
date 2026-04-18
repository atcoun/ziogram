pub const RefundStarPayment = struct {
    user_id: i32,
    telegram_payment_charge_id: []const u8,

    pub const ReturnType = bool;
    pub const api_method = "refundStarPayment";
};
