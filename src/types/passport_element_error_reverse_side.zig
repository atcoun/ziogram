const enums = @import("../enums.zig");

pub const PassportElementErrorReverseSide = struct {
    source: enums.PassportElementErrorSource = .reverse_side,
    type: enums.PassportElementType,
    file_hash: []const u8,
    message: []const u8,
};
