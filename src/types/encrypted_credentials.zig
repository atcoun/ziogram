pub const EncryptedCredentials = struct {
    data: []const u8,
    hash: []const u8,
    secret: []const u8,
};
