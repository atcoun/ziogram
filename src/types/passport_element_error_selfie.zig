const enums = @import("../enums.zig");

pub const PassportElementErrorSelfie = struct {
    source: enums.PassportElementErrorSource = .selfie,
    type: enums.PassportElementType,
    file_hash: []const u8,
    message: []const u8,
};
