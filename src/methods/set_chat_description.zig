const types = @import("types");

pub const ReturnType = bool;
pub const api_method = "setChatDescription";

chat_id: types.ChatId,
description: ?[]const u8 = null,
