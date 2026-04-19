const types = @import("../types.zig");

name: ?[]const u8 = null,
phone_number: ?[]const u8 = null,
email: ?[]const u8 = null,
shipping_address: ?types.ShippingAddress = null,
