const types = @import("../types.zig");

pub const SetChatStickerSet = struct {
    chat_id: types.ChatId,
    sticker_set_name: []const u8,

    pub const ReturnType = bool;
    pub const api_method = "setChatStickerSet";
};
