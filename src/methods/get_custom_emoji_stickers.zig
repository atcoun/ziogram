const types = @import("../types.zig");

pub const GetCustomEmojiStickers = struct {
    custom_emoji_ids: []const []const u8,

    pub const ReturnType = []const types.Sticker;
    pub const api_method = "getCustomEmojiStickers";
};
