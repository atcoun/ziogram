const enums = @import("enums");
const types = @import("../types.zig");

id: i32,
text: []const u8,
parse_mode: ?enums.ParseMode = null,
text_entities: ?[]const types.MessageEntity = null,
