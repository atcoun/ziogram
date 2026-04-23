const types = @import("types");

pub const Result = types.ChatInviteLink;
pub const method_name = "revokeChatInviteLink";

chat_id: types.ChatId,
invite_link: []const u8,
