const enums = @import("../enums.zig");

pub const PassportElementErrorFiles = struct {
    source: enums.PassportElementErrorSource = .files,
    type: enums.PassportElementType,
    file_hashes: []const []const u8,
    message: []const u8,
};
