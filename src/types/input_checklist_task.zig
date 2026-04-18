const enums = @import("../enums.zig");
const types = @import("../types.zig");

pub const InputChecklistTask = struct {
    id: i32,
    text: []const u8,
    parse_mode: ?enums.ParseMode = null,
    text_entities: ?[]const types.MessageEntity = null,
};
