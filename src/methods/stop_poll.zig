const types = @import("../types.zig");

pub const StopPoll = struct {
    chat_id: types.ChatId,
    message_id: i32,
    business_connection_id: ?[]const u8 = null,
    reply_markup: ?types.InlineKeyboardMarkup = null,

    pub const ReturnType = types.Poll;
    pub const api_method = "stopPoll";
};
