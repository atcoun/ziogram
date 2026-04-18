const enums = @import("../enums.zig");

pub const PassportElementErrorFile = struct {
    source: enums.PassportElementErrorSource = .file,
    type: enums.PassportElementType,
    file_hash: []const u8,
    message: []const u8,
};
