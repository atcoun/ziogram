const enums = @import("../enums.zig");
const types = @import("../types.zig");

pub const BackgroundTypeWallpaper = struct {
    type: enums.BackgroundTypeKind = .wallpaper,
    document: types.Document,
    dark_theme_dimming: i32,
    is_blurred: ?bool = null,
    is_moving: ?bool = null,
};
