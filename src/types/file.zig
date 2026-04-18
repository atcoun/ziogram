pub const File = struct {
    file_id: []const u8,
    file_unique_id: []const u8,
    file_size: ?i64 = null,
    file_path: ?[]const u8 = null,
};
