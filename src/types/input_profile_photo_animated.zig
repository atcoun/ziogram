const enums = @import("../enums.zig");

pub const InputProfilePhotoAnimated = struct {
    type: enums.InputProfilePhotoType = .animated,
    animation: []const u8,
    main_frame_timestamp: ?f32 = null,
};
