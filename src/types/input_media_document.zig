const enums = @import("enums");
const types = @import("types");

type: enums.InputMediaType = .document,
media: []const u8,
thumbnail: ?[]const u8 = null,
caption: ?[]const u8 = null,
parse_mode: ?enums.ParseMode = null,
caption_entities: ?[]const types.MessageEntity = null,
disable_content_type_detection: ?bool = null,
