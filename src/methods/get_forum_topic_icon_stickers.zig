const types = @import("../types.zig");

pub const GetForumTopicIconStickers = struct {
    pub const ReturnType = []const types.Sticker;
    pub const api_method = "getForumTopicIconStickers";
};
