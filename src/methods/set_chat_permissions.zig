const types = @import("types");

pub const Result = bool;
pub const method_name = "setChatPermissions";

chat_id: types.ChatId,
permissions: types.ChatPermissions,
use_independent_chat_permissions: ?bool = null,
