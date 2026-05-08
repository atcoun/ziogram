const types = @import("types");

photo: ?[]const types.PhotoSize = null,
file_id: []const u8,
file_unique_id: []const u8,
width: i32,
height: i32,
duration: i32,
mime_type: ?[]const u8 = null,
file_size: ?i64 = null,
