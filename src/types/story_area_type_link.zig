const enums = @import("../enums.zig");

pub const StoryAreaTypeLink = struct {
    type: enums.StoryAreaKind = .link,
    url: []const u8,
};
