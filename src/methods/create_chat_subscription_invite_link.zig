const types = @import("../types.zig");

pub const CreateChatSubscriptionInviteLink = struct {
    chat_id: types.ChatId,
    subscription_period: i32,
    subscription_price: i32,
    name: ?[]const u8 = null,

    pub const ReturnType = types.ChatInviteLink;
    pub const api_method = "createChatSubscriptionInviteLink";
};
