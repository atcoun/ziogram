const enums = @import("../enums.zig");

pub const InputPaidMediaPhoto = struct {
    type: enums.InputPaidMediaType = .photo,
    media: []const u8,
};
