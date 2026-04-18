const enums = @import("../enums.zig");
const types = @import("../types.zig");

pub const PaidMediaVideo = struct {
    type: enums.PaidMediaType = .video,
    video: types.Video,
};
