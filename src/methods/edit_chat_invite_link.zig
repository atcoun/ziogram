const types = @import("types");

pub const ReturnType = types.ChatInviteLink;
pub const api_method = "editChatInviteLink";

chat_id: types.ChatId,
invite_link: []const u8,
name: ?[]const u8 = null,
expire_date: ?i32 = null,
member_limit: ?i32 = null,
creates_join_request: ?bool = null,
