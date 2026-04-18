const enums = @import("../enums.zig");

pub const BackgroundFillSolid = struct {
    type: enums.BackgroundFillType = .solid,
    color: i32,
};
