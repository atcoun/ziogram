const types = @import("types");

pub const Result = []const types.GameHighScore;
pub const method_name = "getGameHighScores";

user_id: i64,
chat_id: ?i64 = null,
message_id: ?i32 = null,
inline_message_id: ?[]const u8 = null,
