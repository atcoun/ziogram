const enums = @import("../enums.zig");

pub const RevenueWithdrawalStateFailed = struct {
    type: enums.RevenueWithdrawalStateType = .failed,
};
