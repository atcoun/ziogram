const types = @import("types");

text: []const u8,
entities: ?[]const types.MessageEntity = null,
position: i32,
is_manual: ?bool = null,
