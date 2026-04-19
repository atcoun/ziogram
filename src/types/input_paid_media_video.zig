const enums = @import("enums");

type: enums.InputPaidMediaType = .video,
media: []const u8,
thumbnail: ?[]const u8 = null,
cover: ?[]const u8 = null,
start_timestamp: ?i32 = null,
width: ?i32 = null,
height: ?i32 = null,
duration: ?i32 = null,
supports_streaming: ?bool = null,
