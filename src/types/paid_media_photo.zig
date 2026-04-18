const enums = @import("../enums.zig");
const types = @import("../types.zig");

pub const PaidMediaPhoto = struct {
    type: enums.PaidMediaType = .photo,
    photo: []const types.PhotoSize,
};
