pub const Contact = struct {
    phone_number: []const u8,
    first_name: []const u8,
    last_name: ?[]const u8 = null,
    user_id: ?i64 = null,
    vcard: ?[]const u8 = null,
};
