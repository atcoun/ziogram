const types = @import("../types.zig");

pub const AddStickerToSet = struct {
    user_id: i64,
    name: []const u8,
    sticker: types.InputSticker,
};
