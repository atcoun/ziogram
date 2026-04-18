const std = @import("std");

const enums = @import("../enums.zig");
const types = @import("../types.zig");

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

    pub fn jsonParse(allocator: std.mem.Allocator, source: anytype, options: std.json.ParseOptions) !@This() {
        const value = try std.json.innerParse(std.json.Value, allocator, source, options);
        const source_str = if (value.object.get("source")) |s| s.string else return error.MissingField;
        const err_source = std.meta.stringToEnum(enums.PassportElementErrorSource, source_str) orelse return error.UnknownSource;

        return switch (err_source) {
            .data => .{ .data = try std.json.innerParseFromValue(types.PassportElementErrorDataField, allocator, value, options) },
            .front_side => .{ .front_side = try std.json.innerParseFromValue(types.PassportElementErrorFrontSide, allocator, value, options) },
            .reverse_side => .{ .reverse_side = try std.json.innerParseFromValue(types.PassportElementErrorReverseSide, allocator, value, options) },
            .selfie => .{ .selfie = try std.json.innerParseFromValue(types.PassportElementErrorSelfie, allocator, value, options) },
            .file => .{ .file = try std.json.innerParseFromValue(types.PassportElementErrorFile, allocator, value, options) },
            .files => .{ .files = try std.json.innerParseFromValue(types.PassportElementErrorFiles, allocator, value, options) },
            .translation_file => .{ .translation_file = try std.json.innerParseFromValue(types.PassportElementErrorTranslationFile, allocator, value, options) },
            .translation_files => .{ .translation_files = try std.json.innerParseFromValue(types.PassportElementErrorTranslationFiles, allocator, value, options) },
            .unspecified => .{ .unspecified = try std.json.innerParseFromValue(types.PassportElementErrorUnspecified, allocator, value, options) },
        };
    }
};
