const types = @import("../types.zig");

pub const UserProfilePhotos = struct {
    total_count: i32,
    photos: []const []const types.PhotoSize,
};
