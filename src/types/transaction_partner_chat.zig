const enums = @import("enums");
const types = @import("../types.zig");

type: enums.TransactionPartnerType = .chat,
chat: types.Chat,
gift: ?types.Gift = null,
