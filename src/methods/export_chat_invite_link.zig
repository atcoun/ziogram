const types = @import("../types.zig");

pub const ExportChatInviteLink = struct {
    chat_id: types.ChatId,

    pub const ReturnType = []const u8;
    pub const api_method = "exportChatInviteLink";
};
