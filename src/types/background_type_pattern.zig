const enums = @import("../enums.zig");
const types = @import("../types.zig");

pub const BackgroundTypePattern = struct {
    type: enums.BackgroundTypeKind = .pattern,
    document: types.Document,
    fill: types.BackgroundFill,
    intensity: i32,
    is_inverted: ?bool = null,
    is_moving: ?bool = null,
};
