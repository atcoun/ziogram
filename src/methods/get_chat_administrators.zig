const types = @import("types");

pub const ReturnType = []const types.ChatMember;
pub const api_method = "getChatAdministrators";

chat_id: types.ChatId,
