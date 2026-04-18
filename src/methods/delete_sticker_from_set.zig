pub const DeleteStickerFromSet = struct {
    sticker: []const u8,

    pub const ReturnType = bool;
    pub const api_method = "deleteStickerFromSet";
};
