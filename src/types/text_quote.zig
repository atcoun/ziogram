const types = @import("../types.zig");

pub const TextQuote = struct {
    text: []const u8,
    entities: ?[]const types.MessageEntity = null,
    position: i32,
    is_manual: ?bool = null,
};
