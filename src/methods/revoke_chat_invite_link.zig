const types = @import("types");

pub const ReturnType = types.ChatInviteLink;
pub const api_method = "revokeChatInviteLink";

chat_id: types.ChatId,
invite_link: []const u8,
