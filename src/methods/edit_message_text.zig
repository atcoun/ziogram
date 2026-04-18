const enums = @import("../enums.zig");
const types = @import("../types.zig");

pub const EditMessageText = struct {
    text: []const u8,
    business_connection_id: ?[]const u8 = null,
    chat_id: ?types.ChatId = null,
    message_id: ?i32 = null,
    inline_message_id: ?[]const u8 = null,
    parse_mode: ?enums.ParseMode = null,
    entities: ?[]const types.MessageEntity = null,
    link_preview_options: ?types.LinkPreviewOptions = null,
    reply_markup: ?types.InlineKeyboardMarkup = null,

    pub const ReturnType = types.MessageOrBool;
    pub const api_method = "editMessageText";
};
