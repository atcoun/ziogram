const enums = @import("../enums.zig");
const types = @import("../types.zig");

pub const BackgroundTypeFill = struct {
    type: enums.BackgroundTypeKind = .fill,
    fill: types.BackgroundFill,
    dark_theme_dimming: i32,
};
