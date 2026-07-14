const std = @import("std");

const enums = @import("enums");
const types = @import("types");
const utils = @import("utils");

pub const InputStoryContent = union(enum) {
    photo: types.InputStoryContentPhoto,
    video: types.InputStoryContentVideo,

    const Self = @This();

    pub fn jsonParse(allocator: std.mem.Allocator, source: anytype, options: std.json.ParseOptions) !Self {
        return utils.json.parseTaggedUnion(Self, enums.InputStoryContentType, allocator, source, options);
    }
};
