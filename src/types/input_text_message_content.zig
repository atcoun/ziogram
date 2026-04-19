const enums = @import("enums");
const types = @import("../types.zig");

message_text: []const u8,
parse_mode: ?enums.ParseMode = null,
entities: ?[]const types.MessageEntity = null,
link_preview_options: ?types.LinkPreviewOptions = null,
