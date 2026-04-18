const enums = @import("../enums.zig");

pub const TransactionPartnerTelegramApi = struct {
    type: enums.TransactionPartnerType = .telegram_api,
    request_count: i32,
};
