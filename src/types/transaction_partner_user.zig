const enums = @import("enums");
const types = @import("types");

type: enums.TransactionPartnerType = .user,
transaction_type: enums.TransactionType,
user: types.User,
affiliate: ?types.AffiliateInfo = null,
invoice_payload: ?[]const u8 = null,
subscription_period: ?i32 = null,
paid_media: ?[]const types.PaidMedia = null,
paid_media_payload: ?[]const u8 = null,
gift: ?types.Gift = null,
premium_subscription_duration: ?i32 = null,
