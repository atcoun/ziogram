const types = @import("../types.zig");

pub const EditGeneralForumTopic = struct {
    chat_id: types.ChatId,
    name: []const u8,

    pub const ReturnType = bool;
    pub const api_method = "editGeneralForumTopic";
};
