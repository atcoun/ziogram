const enums = @import("../enums.zig");

pub const InputProfilePhotoStatic = struct {
    type: enums.InputProfilePhotoType = .static,
    photo: []const u8,
};
