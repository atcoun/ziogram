const enums = @import("enums");
const types = @import("types");

pub const Result = bool;
pub const method_name = "giftPremiumSubscription";

user_id: i64,
month_count: i32,
star_count: i32,
text: ?[]const u8 = null,
text_parse_mode: ?enums.ParseMode = null,
text_entities: ?[]const types.MessageEntity = null,
