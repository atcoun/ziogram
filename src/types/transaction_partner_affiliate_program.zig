const enums = @import("../enums.zig");
const types = @import("../types.zig");

pub const TransactionPartnerAffiliateProgram = struct {
    type: enums.TransactionPartnerType = .affiliate_program,
    sponsor_user: ?types.User = null,
    commission_per_mille: i32,
};
