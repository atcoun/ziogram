const enums = @import("../enums.zig");

pub const TransactionPartnerTelegramAds = struct {
    type: enums.TransactionPartnerType = .telegram_ads,
};
