const enums = @import("../enums.zig");

pub const BackgroundFillFreeformGradient = struct {
    type: enums.BackgroundFillType = .freeform_gradient,
    colors: []const i32,
};
