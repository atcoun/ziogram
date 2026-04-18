const types = @import("../types.zig");

pub const SavePreparedKeyboardButton = struct {
    user_id: i32,
    button: types.KeyboardButton,

    pub const ReturnType = types.PreparedKeyboardButton;
    pub const api_method = "savePreparedKeyboardButton";
};
