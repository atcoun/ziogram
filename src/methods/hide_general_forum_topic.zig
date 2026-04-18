const types = @import("../types.zig");

pub const HideGeneralForumTopic = struct {
    chat_id: types.ChatId,

    pub const ReturnType = bool;
    pub const api_method = "hideGeneralForumTopic";
};
