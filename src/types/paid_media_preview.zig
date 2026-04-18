const enums = @import("../enums.zig");

pub const PaidMediaPreview = struct {
    type: enums.PaidMediaType = .preview,
    width: ?i32 = null,
    height: ?i32 = null,
    duration: ?i32 = null,
};
