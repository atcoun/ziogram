const enums = @import("../enums.zig");

pub const InputStoryContentPhoto = struct {
    type: enums.InputStoryContentType = .photo,
    photo: []const u8,
};
