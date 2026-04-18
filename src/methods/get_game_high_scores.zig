const types = @import("../types.zig");

pub const GetGameHighScores = struct {
    user_id: i32,
    chat_id: ?i32 = null,
    message_id: ?i32 = null,
    inline_message_id: ?[]const u8 = null,

    pub const ReturnType = []const types.GameHighScore;
    pub const api_method = "getGameHighScores";
};
