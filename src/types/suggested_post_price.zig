const enums = @import("../enums.zig");

pub const SuggestedPostPrice = struct {
    currency: enums.Currency,
    amount: i32,
};
