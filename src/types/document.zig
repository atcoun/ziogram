const types = @import("../types.zig");

pub const Document = struct {
    file_id: []const u8,
    file_unique_id: []const u8,
    thumbnail: ?types.PhotoSize = null,
    file_name: ?[]const u8 = null,
    mime_type: ?[]const u8 = null,
    file_size: ?i64 = null,
};
