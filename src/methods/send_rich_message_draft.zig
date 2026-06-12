const types = @import("types");

pub const Result = bool;
pub const method_name = "sendRichMessageDraft";

chat_id: i64,
draft_id: i32,
rich_message: types.InputRichMessage,
message_thread_id: ?i32 = null,
