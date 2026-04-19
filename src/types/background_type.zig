const std = @import("std");

const enums = @import("enums");
const types = @import("../types.zig");

pub const BackgroundType = union(enum) {
    fill: types.BackgroundTypeFill,
    wallpaper: types.BackgroundTypeWallpaper,
    pattern: types.BackgroundTypePattern,
    chat_theme: types.BackgroundTypeChatTheme,

    pub fn jsonParse(allocator: std.mem.Allocator, source: anytype, options: std.json.ParseOptions) !@This() {
        const value = try std.json.innerParse(std.json.Value, allocator, source, options);
        const type_str = if (value.object.get("type")) |t| t.string else return error.MissingField;
        const kind = std.meta.stringToEnum(enums.BackgroundTypeKind, type_str) orelse return error.InvalidCharacter;

        return switch (kind) {
            .fill => .{ .fill = try std.json.innerParseFromValue(types.BackgroundTypeFill, allocator, value, options) },
            .wallpaper => .{ .wallpaper = try std.json.innerParseFromValue(types.BackgroundTypeWallpaper, allocator, value, options) },
            .pattern => .{ .pattern = try std.json.innerParseFromValue(types.BackgroundTypePattern, allocator, value, options) },
            .chat_theme => .{ .chat_theme = try std.json.innerParseFromValue(types.BackgroundTypeChatTheme, allocator, value, options) },
        };
    }
};
