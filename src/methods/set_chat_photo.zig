const types = @import("../types.zig");

pub const SetChatPhoto = struct {
    chat_id: types.ChatId,
    photo: types.InputFile,

    pub const ReturnType = bool;
    pub const api_method = "setChatPhoto";
};
