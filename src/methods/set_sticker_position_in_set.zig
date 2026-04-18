pub const SetStickerPositionInSet = struct {
    sticker: []const u8,
    position: i32,

    pub const ReturnType = bool;
    pub const api_method = "setStickerPositionInSet";
};
