const types = @import("types");

pub const Result = []const types.ChatMember;
pub const method_name = "getChatAdministrators";

chat_id: types.ChatId,
return_bots: ?bool = null,
