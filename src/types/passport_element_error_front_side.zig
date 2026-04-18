const enums = @import("../enums.zig");

pub const PassportElementErrorFrontSide = struct {
    source: enums.PassportElementErrorSource = .front_side,
    type: enums.PassportElementType,
    file_hash: []const u8,
    message: []const u8,
};
