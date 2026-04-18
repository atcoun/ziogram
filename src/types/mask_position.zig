const enums = @import("../enums.zig");

pub const MaskPosition = struct {
    point: enums.MaskPositionPoint,
    x_shift: f32,
    y_shift: f32,
    scale: f32,
};
