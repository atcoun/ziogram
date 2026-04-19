const types = @import("types");

pub const ReturnType = []const types.GameHighScore;
pub const api_method = "getGameHighScores";

user_id: i64,
chat_id: ?i64 = null,
message_id: ?i32 = null,
inline_message_id: ?[]const u8 = null,
