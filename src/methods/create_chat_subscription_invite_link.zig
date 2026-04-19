const types = @import("types");

pub const ReturnType = types.ChatInviteLink;
pub const api_method = "createChatSubscriptionInviteLink";

chat_id: types.ChatId,
subscription_period: i32,
subscription_price: i32,
name: ?[]const u8 = null,
