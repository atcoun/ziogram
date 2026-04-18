const types = @import("../types.zig");

pub const CreateChatInviteLink = struct {
    chat_id: types.ChatId,
    name: ?[]const u8 = null,
    expire_date: ?i32 = null,
    member_limit: ?i32 = null,
    creates_join_request: ?bool = null,

    pub const ReturnType = types.ChatInviteLink;
    pub const api_method = "createChatInviteLink";
};
