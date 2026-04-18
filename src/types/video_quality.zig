pub const VideoQuality = struct {
    file_id: []const u8,
    file_unique_id: []const u8,
    width: i32,
    height: i32,
    codec: []const u8,
    file_size: ?i64 = null,
};
