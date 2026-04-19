const types = @import("types");

pub const ReturnType = types.ChatInviteLink;
pub const api_method = "editChatSubscriptionInviteLink";

chat_id: types.ChatId,
invite_link: []const u8,
name: ?[]const u8 = null,
