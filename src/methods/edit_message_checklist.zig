const types = @import("../types.zig");

pub const EditMessageChecklist = struct {
    business_connection_id: []const u8,
    chat_id: i32,
    message_id: i32,
    checklist: types.InputChecklist,
    reply_markup: ?types.InlineKeyboardMarkup = null,

    pub const ReturnType = types.Message;
    pub const api_method = "editMessageChecklist";
};
