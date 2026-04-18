const enums = @import("../enums.zig");

pub const RevenueWithdrawalStateSucceeded = struct {
    type: enums.RevenueWithdrawalStateType = .succeeded,
    date: i32,
    url: []const u8,
};
