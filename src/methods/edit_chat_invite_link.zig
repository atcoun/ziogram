const types = @import("types");

pub const Result = types.ChatInviteLink;
pub const method_name = "editChatInviteLink";

chat_id: types.ChatId,
invite_link: []const u8,
name: ?[]const u8 = null,
expire_date: ?i32 = null,
member_limit: ?i32 = null,
creates_join_request: ?bool = null,
