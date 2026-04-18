const enums = @import("../enums.zig");
const types = @import("../types.zig");

pub const SendMessageDraft = struct {
    chat_id: i64,
    draft_id: i32,
    text: []const u8,
    message_thread_id: ?i32 = null,
    parse_mode: ?enums.ParseMode = null,
    entities: ?[]const types.MessageEntity = null,

    pub const ReturnType = bool;
    pub const api_method = "sendMessageDraft";
};
