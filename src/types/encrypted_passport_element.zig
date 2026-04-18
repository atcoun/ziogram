const enums = @import("../enums.zig");
const types = @import("../types.zig");

pub const EncryptedPassportElement = struct {
    type: enums.PassportElementType,
    data: ?[]const u8 = null,
    phone_number: ?[]const u8 = null,
    email: ?[]const u8 = null,
    files: ?[]const types.PassportFile = null,
    front_side: ?types.PassportFile = null,
    reverse_side: ?types.PassportFile = null,
    selfie: ?types.PassportFile = null,
    translation: ?[]const types.PassportFile = null,
    hash: []const u8,
};
