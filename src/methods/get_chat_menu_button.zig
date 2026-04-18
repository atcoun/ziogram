const types = @import("../types.zig");

pub const GetChatMenuButton = struct {
    chat_id: ?i32 = null,

    pub const ReturnType = types.MenuButton;
    pub const api_method = "getChatMenuButton";
};
