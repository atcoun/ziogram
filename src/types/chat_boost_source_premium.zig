const enums = @import("../enums.zig");
const types = @import("../types.zig");

pub const ChatBoostSourcePremium = struct {
    source: enums.ChatBoostSourceType = .premium,
    user: types.User,
};
