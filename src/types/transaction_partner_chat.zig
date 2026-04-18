const enums = @import("../enums.zig");
const types = @import("../types.zig");

pub const TransactionPartnerChat = struct {
    type: enums.TransactionPartnerType = .chat,
    chat: types.Chat,
    gift: ?types.Gift = null,
};
