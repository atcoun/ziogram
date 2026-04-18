const types = @import("../types.zig");

pub const GetChat = struct {
    chat_id: types.ChatId,

    pub const ReturnType = types.ChatFullInfo;
    pub const api_method = "getChat";
};
