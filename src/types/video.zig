const types = @import("types");

file_id: []const u8,
file_unique_id: []const u8,
width: i32,
height: i32,
duration: i32,
thumbnail: ?types.PhotoSize = null,
cover: ?[]const types.PhotoSize = null,
start_timestamp: ?i32 = null,
qualities: ?[]const types.VideoQuality = null,
file_name: ?[]const u8 = null,
mime_type: ?[]const u8 = null,
file_size: ?i64 = null,
