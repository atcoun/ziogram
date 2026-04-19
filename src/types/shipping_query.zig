const types = @import("../types.zig");

id: []const u8,
from: types.User,
invoice_payload: []const u8,
shipping_address: types.ShippingAddress,
