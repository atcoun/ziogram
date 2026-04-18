const types = @import("../types.zig");

pub const ForwardMessage = struct {
    chat_id: types.ChatId,
    from_chat_id: types.ChatId,
    message_id: i32,
    message_thread_id: ?i32 = null,
    direct_messages_topic_id: ?i32 = null,
    video_start_timestamp: ?i32 = null,
    disable_notification: ?bool = null,
    protect_content: ?bool = null,
    message_effect_id: ?[]const u8 = null,
    suggested_post_parameters: ?types.SuggestedPostParameters = null,

    pub const ReturnType = types.Message;
    pub const api_method = "forwardMessage";
};
