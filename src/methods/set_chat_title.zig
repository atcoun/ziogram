const types = @import("types");

pub const ReturnType = bool;
pub const api_method = "setChatTitle";

chat_id: types.ChatId,
title: []const u8,
