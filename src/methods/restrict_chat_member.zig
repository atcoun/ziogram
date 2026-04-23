const types = @import("types");

pub const Result = bool;
pub const method_name = "restrictChatMember";

chat_id: types.ChatId,
user_id: i64,
permissions: types.ChatPermissions,
use_independent_chat_permissions: ?bool = null,
until_date: ?i32 = null,
