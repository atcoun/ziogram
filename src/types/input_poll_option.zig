const enums = @import("enums");
const types = @import("types");

text: []const u8,
text_parse_mode: ?enums.ParseMode = null,
text_entities: ?[]const types.MessageEntity = null,
