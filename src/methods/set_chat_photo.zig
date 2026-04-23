const types = @import("types");

pub const Result = bool;
pub const method_name = "setChatPhoto";

chat_id: types.ChatId,
photo: types.InputFile,
