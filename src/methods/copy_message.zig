const enums = @import("../enums.zig");
const types = @import("../types.zig");

pub const CopyMessage = struct {
    chat_id: types.ChatId,
    from_chat_id: types.ChatId,
    message_id: i32,
    message_thread_id: ?i32 = null,
    direct_messages_topic_id: ?i32 = null,
    video_start_timestamp: ?i32 = null,
    caption: ?[]const u8 = null,
    parse_mode: ?enums.ParseMode = null,
    caption_entities: ?[]const types.MessageEntity = null,
    show_caption_above_media: ?bool = null,
    disable_notification: ?bool = null,
    protect_content: ?bool = null,
    allow_paid_broadcast: ?bool = null,
    message_effect_id: ?[]const u8 = null,
    suggested_post_parameters: ?types.SuggestedPostParameters = null,
    reply_parameters: ?types.ReplyParameters = null,
    reply_markup: ?types.ReplyMarkup = null,

    pub const ReturnType = types.MessageId;
    pub const api_method = "copyMessage";
};
