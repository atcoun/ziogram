pub const DeleteStickerSet = struct {
    name: []const u8,

    pub const ReturnType = bool;
    pub const api_method = "deleteStickerSet";
};
