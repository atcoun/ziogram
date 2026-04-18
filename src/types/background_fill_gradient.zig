const enums = @import("../enums.zig");

pub const BackgroundFillGradient = struct {
    type: enums.BackgroundFillType = .gradient,
    top_color: i32,
    bottom_color: i32,
    rotation_angle: i32,
};
