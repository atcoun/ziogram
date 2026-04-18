const enums = @import("../enums.zig");
const types = @import("../types.zig");

pub const SendPaidMedia = struct {
    chat_id: types.ChatId,
    star_count: i32,
    media: []const types.InputPaidMedia,
    business_connection_id: ?[]const u8 = null,
    message_thread_id: ?i32 = null,
    direct_messages_topic_id: ?i32 = null,
    payload: ?[]const u8 = null,
    caption: ?[]const u8 = null,
    parse_mode: ?enums.ParseMode = null,
    caption_entities: ?[]const types.MessageEntity = null,
    show_caption_above_media: ?bool = null,
    disable_notification: ?bool = null,
    protect_content: ?bool = null,
    allow_paid_broadcast: ?bool = null,
    suggested_post_parameters: ?types.SuggestedPostParameters = null,
    reply_parameters: ?types.ReplyParameters = null,
    reply_markup: ?types.ReplyMarkup = null,

    pub const ReturnType = types.Message;
    pub const api_method = "sendPaidMedia";
};
