const types = @import("../types.zig");

pub const GetStickerSet = struct {
    name: []const u8,

    pub const ReturnType = types.StickerSet;
    pub const api_method = "getStickerSet";
};
