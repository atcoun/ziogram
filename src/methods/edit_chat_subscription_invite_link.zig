const types = @import("../types.zig");

pub const EditChatSubscriptionInviteLink = struct {
    chat_id: types.ChatId,
    invite_link: []const u8,
    name: ?[]const u8 = null,

    pub const ReturnType = types.ChatInviteLink;
    pub const api_method = "editChatSubscriptionInviteLink";
};
