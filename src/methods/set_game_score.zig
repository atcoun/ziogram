const types = @import("../types.zig");

pub const SetGameScore = struct {
    user_id: i32,
    score: i32,
    force: ?bool = null,
    disable_edit_message: ?bool = null,
    chat_id: ?i32 = null,
    message_id: ?i32 = null,
    inline_message_id: ?[]const u8 = null,

    pub const ReturnType = types.MessageOrBool;
    pub const api_method = "setGameScore";
};
