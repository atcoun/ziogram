const types = @import("types");

pub const Result = types.ChatInviteLink;
pub const method_name = "createChatSubscriptionInviteLink";

chat_id: types.ChatId,
subscription_period: i32,
subscription_price: i32,
name: ?[]const u8 = null,
