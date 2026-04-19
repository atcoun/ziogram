const enums = @import("enums");
const types = @import("types");

type: enums.InputMediaType = .video,
media: []const u8,
thumbnail: ?[]const u8 = null,
cover: ?[]const u8 = null,
start_timestamp: ?i32 = null,
caption: ?[]const u8 = null,
parse_mode: ?enums.ParseMode = null,
caption_entities: ?[]const types.MessageEntity = null,
show_caption_above_media: ?bool = null,
width: ?i32 = null,
height: ?i32 = null,
duration: ?i32 = null,
supports_streaming: ?bool = null,
has_spoiler: ?bool = null,
