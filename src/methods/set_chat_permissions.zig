const types = @import("../types.zig");

pub const SetChatPermissions = struct {
    chat_id: types.ChatId,
    permissions: types.ChatPermissions,
    use_independent_chat_permissions: ?bool = null,

    pub const ReturnType = bool;
    pub const api_method = "setChatPermissions";
};
