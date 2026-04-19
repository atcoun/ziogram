const types = @import("types");

pub const ReturnType = bool;
pub const api_method = "verifyChat";

chat_id: types.ChatId,
custom_description: ?[]const u8 = null,
