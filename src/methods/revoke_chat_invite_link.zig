const types = @import("../types.zig");

pub const RevokeChatInviteLink = struct {
    chat_id: types.ChatId,
    invite_link: []const u8,

    pub const ReturnType = types.ChatInviteLink;
    pub const api_method = "revokeChatInviteLink";
};
