pub const PhotoSize = struct {
    file_id: []const u8,
    file_unique_id: []const u8,
    width: i32,
    height: i32,
    file_size: ?i32 = null,
};
