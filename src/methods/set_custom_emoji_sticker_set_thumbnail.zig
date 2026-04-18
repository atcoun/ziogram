pub const SetCustomEmojiStickerSetThumbnail = struct {
    name: []const u8,
    custom_emoji_id: ?[]const u8 = null,

    pub const ReturnType = bool;
    pub const api_method = "setCustomEmojiStickerSetThumbnail";
};
