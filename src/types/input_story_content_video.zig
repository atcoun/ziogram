const enums = @import("enums");

type: enums.InputStoryContentType = .video,
video: []const u8,
duration: ?f32 = null,
cover_frame_timestamp: ?f32 = null,
is_animation: ?bool = null,
