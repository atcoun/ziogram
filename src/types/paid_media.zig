const std = @import("std");

const enums = @import("enums");
const types = @import("types");
const utils = @import("utils");

pub const PaidMedia = union(enum) {
    preview: types.PaidMediaPreview,
    photo: types.PaidMediaPhoto,
    video: types.PaidMediaVideo,

    const Self = @This();

    pub fn jsonParse(allocator: std.mem.Allocator, source: anytype, options: std.json.ParseOptions) !Self {
        return utils.json.parseTaggedUnion(Self, enums.PaidMediaType, allocator, source, options);
    }
};
