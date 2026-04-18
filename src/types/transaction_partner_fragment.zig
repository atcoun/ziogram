const enums = @import("../enums.zig");
const types = @import("../types.zig");

pub const TransactionPartnerFragment = struct {
    type: enums.TransactionPartnerType = .fragment,
    withdrawal_state: ?types.RevenueWithdrawalState = null,
};
