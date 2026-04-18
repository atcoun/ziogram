const types = @import("../types.zig");

pub const PassportData = struct {
    data: []const types.EncryptedPassportElement,
    credentials: types.EncryptedCredentials,
};
