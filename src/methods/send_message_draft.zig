const enums = @import("enums");
const types = @import("types");

pub const Result = bool;
pub const method_name = "sendMessageDraft";

chat_id: i64,
draft_id: i32,
text: []const u8,
message_thread_id: ?i32 = null,
parse_mode: ?enums.ParseMode = null,
entities: ?[]const types.MessageEntity = null,
