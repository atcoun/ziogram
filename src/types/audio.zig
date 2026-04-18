const types = @import("../types.zig");

pub const Audio = struct {
    file_id: []const u8,
    file_unique_id: []const u8,
    duration: i32,
    performer: ?[]const u8 = null,
    title: ?[]const u8 = null,
    file_name: ?[]const u8 = null,
    mime_type: ?[]const u8 = null,
    file_size: ?i64 = null,
    thumbnail: ?types.PhotoSize = null,
};
