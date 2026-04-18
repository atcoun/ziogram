pub const SetStickerSetTitle = struct {
    name: []const u8,
    title: []const u8,

    pub const ReturnType = bool;
    pub const api_method = "setStickerSetTitle";
};
