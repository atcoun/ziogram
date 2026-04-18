const types = @import("../types.zig");

pub const DeleteChatStickerSet = struct {
    chat_id: types.ChatId,

    pub const ReturnType = bool;
    pub const api_method = "deleteChatStickerSet";
};
