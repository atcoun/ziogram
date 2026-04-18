const enums = @import("../enums.zig");
const types = @import("../types.zig");

pub const SendGift = struct {
    gift_id: []const u8,
    user_id: ?i32 = null,
    chat_id: ?types.ChatId = null,
    pay_for_upgrade: ?bool = null,
    text: ?[]const u8 = null,
    text_parse_mode: ?enums.ParseMode = null,
    text_entities: ?[]const types.MessageEntity = null,

    pub const ReturnType = bool;
    pub const api_method = "sendGift";
};
