const types = @import("../types.zig");

pub const VideoNote = struct {
    file_id: []const u8,
    file_unique_id: []const u8,
    length: i32,
    duration: i32,
    thumbnail: ?types.PhotoSize = null,
    file_size: ?i32 = null,
};
