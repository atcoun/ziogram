pub const SetStickerEmojiList = struct {
    sticker: []const u8,
    emoji_list: []const []const u8,

    pub const ReturnType = bool;
    pub const api_method = "setStickerEmojiList";
};
