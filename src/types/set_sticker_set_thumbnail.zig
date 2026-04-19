const types = @import("../types.zig");

name: []const u8,
user_id: i64,
thumbnail: ?types.InputFile = null,
format: []const u8,
