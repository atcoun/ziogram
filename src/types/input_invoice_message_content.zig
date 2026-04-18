const types = @import("../types.zig");

pub const InputInvoiceMessageContent = struct {
    title: []const u8,
    description: []const u8,
    payload: []const u8,
    provider_token: ?[]const u8 = null,
    currency: []const u8,
    prices: []const types.LabeledPrice,
    max_tip_amount: ?i32 = null,
    suggested_tip_amounts: ?[]const i32 = null,
    provider_data: ?[]const u8 = null,
    photo_url: ?[]const u8 = null,
    photo_size: ?i32 = null,
    photo_width: ?i32 = null,
    photo_height: ?i32 = null,
    need_name: ?bool = null,
    need_phone_number: ?bool = null,
    need_email: ?bool = null,
    need_shipping_address: ?bool = null,
    send_phone_number_to_provider: ?bool = null,
    send_email_to_provider: ?bool = null,
    is_flexible: ?bool = null,
};
