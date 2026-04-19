const enums = @import("enums");
const types = @import("types");

pub const ReturnType = bool;
pub const api_method = "sendGift";

gift_id: []const u8,
user_id: ?i64 = null,
chat_id: ?types.ChatId = null,
pay_for_upgrade: ?bool = null,
text: ?[]const u8 = null,
text_parse_mode: ?enums.ParseMode = null,
text_entities: ?[]const types.MessageEntity = null,
