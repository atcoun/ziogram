const types = @import("../types.zig");

pub const SetChatMenuButton = struct {
    chat_id: ?i32 = null,
    menu_button: ?types.MenuButton = null,

    pub const ReturnType = bool;
    pub const api_method = "setChatMenuButton";
};
