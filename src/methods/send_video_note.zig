const types = @import("../types.zig");

pub const SendVideoNote = struct {
    chat_id: types.ChatId,
    video_note: types.InputFile,
    business_connection_id: ?[]const u8 = null,
    message_thread_id: ?i32 = null,
    direct_messages_topic_id: ?i32 = null,
    duration: ?i32 = null,
    length: ?i32 = null,
    thumbnail: ?types.InputFile = null,
    disable_notification: ?bool = null,
    protect_content: ?bool = null,
    allow_paid_broadcast: ?bool = null,
    message_effect_id: ?[]const u8 = null,
    suggested_post_parameters: ?types.SuggestedPostParameters = null,
    reply_parameters: ?types.ReplyParameters = null,
    reply_markup: ?types.ReplyMarkup = null,

    pub const ReturnType = types.Message;
    pub const api_method = "sendVideoNote";
};
