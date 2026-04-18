const enums = @import("../enums.zig");
const types = @import("../types.zig");

pub const SendPoll = struct {
    chat_id: types.ChatId,
    question: []const u8,
    options: []const types.InputPollOption,
    business_connection_id: ?[]const u8 = null,
    message_thread_id: ?i32 = null,
    question_parse_mode: ?enums.ParseMode = null,
    question_entities: ?[]const types.MessageEntity = null,
    is_anonymous: ?bool = null,
    type: ?[]const u8 = null,
    allows_multiple_answers: ?bool = null,
    correct_option_id: ?i32 = null,
    explanation: ?[]const u8 = null,
    explanation_parse_mode: ?enums.ParseMode = null,
    explanation_entities: ?[]const types.MessageEntity = null,
    open_period: ?i32 = null,
    close_date: ?i32 = null,
    is_closed: ?bool = null,
    description: ?[]const u8 = null,
    description_parse_mode: ?enums.ParseMode = null,
    description_entities: ?[]const types.MessageEntity = null,
    disable_notification: ?bool = null,
    protect_content: ?bool = null,
    allow_paid_broadcast: ?bool = null,
    message_effect_id: ?[]const u8 = null,
    reply_parameters: ?types.ReplyParameters = null,
    reply_markup: ?types.ReplyMarkup = null,

    pub const ReturnType = types.Message;
    pub const api_method = "sendPoll";
};
