const enums = @import("../enums.zig");

pub const PassportElementErrorUnspecified = struct {
    source: enums.PassportElementErrorSource = .unspecified,
    type: enums.PassportElementType,
    element_hash: []const u8,
    message: []const u8,
};
