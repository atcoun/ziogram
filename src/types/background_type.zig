const std = @import("std");

const enums = @import("enums");
const types = @import("types");
const utils = @import("utils");

pub const BackgroundType = union(enum) {
    fill: types.BackgroundTypeFill,
    wallpaper: types.BackgroundTypeWallpaper,
    pattern: types.BackgroundTypePattern,
    chat_theme: types.BackgroundTypeChatTheme,

    const Self = @This();

    pub fn jsonParse(allocator: std.mem.Allocator, source: anytype, options: std.json.ParseOptions) !Self {
        return utils.json.parseTaggedUnion(Self, enums.BackgroundTypeKind, allocator, source, options);
    }
};
