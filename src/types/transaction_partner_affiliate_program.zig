const enums = @import("enums");
const types = @import("../types.zig");

type: enums.TransactionPartnerType = .affiliate_program,
sponsor_user: ?types.User = null,
commission_per_mille: i32,
