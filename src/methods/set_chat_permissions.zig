const types = @import("types");

pub const ReturnType = bool;
pub const api_method = "setChatPermissions";

chat_id: types.ChatId,
permissions: types.ChatPermissions,
use_independent_chat_permissions: ?bool = null,
