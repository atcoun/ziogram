const types = @import("types");

pub const ReturnType = types.PreparedKeyboardButton;
pub const api_method = "savePreparedKeyboardButton";

user_id: i64,
button: types.KeyboardButton,
