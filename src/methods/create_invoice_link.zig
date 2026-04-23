const types = @import("types");

pub const Result = []const u8;
pub const method_name = "createInvoiceLink";

title: []const u8,
description: []const u8,
payload: []const u8,
currency: []const u8,
prices: []const types.LabeledPrice,
business_connection_id: ?[]const u8 = null,
provider_token: ?[]const u8 = null,
subscription_period: ?i32 = null,
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
