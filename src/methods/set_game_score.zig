const types = @import("types");

pub const Result = types.MessageOrBool;
pub const method_name = "setGameScore";

user_id: i64,
score: i32,
force: ?bool = null,
disable_edit_message: ?bool = null,
chat_id: ?i64 = null,
message_id: ?i32 = null,
inline_message_id: ?[]const u8 = null,
