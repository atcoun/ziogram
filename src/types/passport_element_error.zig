const std = @import("std");

const enums = @import("enums");
const types = @import("types");
const utils = @import("utils");

pub const PassportElementError = union(enum) {
    data: types.PassportElementErrorDataField,
    front_side: types.PassportElementErrorFrontSide,
    reverse_side: types.PassportElementErrorReverseSide,
    selfie: types.PassportElementErrorSelfie,
    file: types.PassportElementErrorFile,
    files: types.PassportElementErrorFiles,
    translation_file: types.PassportElementErrorTranslationFile,
    translation_files: types.PassportElementErrorTranslationFiles,
    unspecified: types.PassportElementErrorUnspecified,

    const Self = @This();

    pub fn jsonParse(allocator: std.mem.Allocator, source: anytype, options: std.json.ParseOptions) !Self {
        return utils.json.parseTaggedUnion(Self, enums.PassportElementErrorSource, allocator, source, options);
    }
};
