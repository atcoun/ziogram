const types = @import("../types.zig");

pub const UserProfileAudios = struct {
    total_count: i32,
    audios: []const types.Audio,
};
