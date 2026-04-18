const enums = @import("../enums.zig");

pub const PassportElementErrorTranslationFile = struct {
    source: enums.PassportElementErrorSource = .translation_file,
    type: enums.PassportElementType,
    file_hash: []const u8,
    message: []const u8,
};
