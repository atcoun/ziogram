const std = @import("std");

const enums = @import("enums");
const types = @import("types");
const utils = @import("utils");

pub const StoryAreaType = union(enum) {
    location: types.StoryAreaTypeLocation,
    suggested_reaction: types.StoryAreaTypeSuggestedReaction,
    link: types.StoryAreaTypeLink,
    weather: types.StoryAreaTypeWeather,
    unique_gift: types.StoryAreaTypeUniqueGift,

    const Self = @This();

    pub fn jsonParse(allocator: std.mem.Allocator, source: anytype, options: std.json.ParseOptions) !Self {
        return utils.json.parseTaggedUnion(Self, enums.StoryAreaKind, allocator, source, options);
    }
};
