const enums = @import("../enums.zig");

pub const StoryAreaTypeUniqueGift = struct {
    type: enums.StoryAreaKind = .unique_gift,
    name: []const u8,
};
