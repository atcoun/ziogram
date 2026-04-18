pub const SetStickerKeywords = struct {
    sticker: []const u8,
    keywords: ?[]const []const u8 = null,

    pub const ReturnType = bool;
    pub const api_method = "setStickerKeywords";
};
