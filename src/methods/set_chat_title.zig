const types = @import("types");

pub const Result = bool;
pub const method_name = "setChatTitle";

chat_id: types.ChatId,
title: []const u8,
