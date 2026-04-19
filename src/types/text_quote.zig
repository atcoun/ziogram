const types = @import("../types.zig");

text: []const u8,
entities: ?[]const types.MessageEntity = null,
position: i32,
is_manual: ?bool = null,
