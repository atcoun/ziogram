const types = @import("../types.zig");

pub const SetStickerSetThumbnail = struct {
    name: []const u8,
    user_id: i64,
    thumbnail: ?types.InputFile = null,
    format: []const u8,
};
