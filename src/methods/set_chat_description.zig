const types = @import("types");

pub const Result = bool;
pub const method_name = "setChatDescription";

chat_id: types.ChatId,
description: ?[]const u8 = null,
