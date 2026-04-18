const enums = @import("../enums.zig");
const types = @import("../types.zig");

pub const ChatBoostSourceGiftCode = struct {
    source: enums.ChatBoostSourceType = .gift_code,
    user: types.User,
};
