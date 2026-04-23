const types = @import("types");

pub const Result = bool;
pub const method_name = "verifyChat";

chat_id: types.ChatId,
custom_description: ?[]const u8 = null,
