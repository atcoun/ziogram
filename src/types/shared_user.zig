const types = @import("../types.zig");

pub const SharedUser = struct {
    user_id: i64,
    first_name: ?[]const u8 = null,
    last_name: ?[]const u8 = null,
    username: ?[]const u8 = null,
    photo: ?[]const types.PhotoSize = null,
};
