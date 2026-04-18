const enums = @import("../enums.zig");

pub const PassportElementErrorTranslationFiles = struct {
    source: enums.PassportElementErrorSource = .translation_files,
    type: enums.PassportElementType,
    file_hashes: []const []const u8,
    message: []const u8,
};
