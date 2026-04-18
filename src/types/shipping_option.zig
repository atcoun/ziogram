const types = @import("../types.zig");

pub const ShippingOption = struct {
    id: []const u8,
    title: []const u8,
    prices: []const types.LabeledPrice,
};
