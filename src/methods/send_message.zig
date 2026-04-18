const enums = @import("../enums.zig");
const types = @import("../types.zig");

pub const SendMessage = struct {
    chat_id: types.ChatId,
    text: []const u8,
    business_connection_id: ?[]const u8 = null,
    message_thread_id: ?i32 = null,
    direct_messages_topic_id: ?i32 = null,
    parse_mode: ?enums.ParseMode = null,
    entities: ?[]const types.MessageEntity = null,
    link_preview_options: ?types.LinkPreviewOptions = null,
    disable_notification: ?bool = null,
    protect_content: ?bool = null,
    allow_paid_broadcast: ?bool = null,
    message_effect_id: ?[]const u8 = null,
    reply_parameters: ?types.ReplyParameters = null,
    reply_markup: ?types.ReplyMarkup = null,

    pub const ReturnType = types.Message;
    pub const api_method = "sendMessage";
};
