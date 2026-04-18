pub const Voice = struct {
    file_id: []const u8,
    file_unique_id: []const u8,
    duration: i32,
    mime_type: ?[]const u8 = null,
    file_size: ?i64 = null,
};
