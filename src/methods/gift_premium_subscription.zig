const enums = @import("../enums.zig");
const types = @import("../types.zig");

pub const GiftPremiumSubscription = struct {
    user_id: i32,
    month_count: i32,
    star_count: i32,
    text: ?[]const u8 = null,
    text_parse_mode: ?enums.ParseMode = null,
    text_entities: ?[]const types.MessageEntity = null,

    pub const ReturnType = bool;
    pub const api_method = "giftPremiumSubscription";
};
