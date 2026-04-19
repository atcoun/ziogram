const std = @import("std");

const enums = @import("enums");
const types = @import("types");

pub const StoryAreaType = union(enum) {
    location: types.StoryAreaTypeLocation,
    suggested_reaction: types.StoryAreaTypeSuggestedReaction,
    link: types.StoryAreaTypeLink,
    weather: types.StoryAreaTypeWeather,
    unique_gift: types.StoryAreaTypeUniqueGift,

    pub fn jsonParse(allocator: std.mem.Allocator, source: anytype, options: std.json.ParseOptions) !@This() {
        const value = try std.json.innerParse(std.json.Value, allocator, source, options);
        const type_str = if (value.object.get("type")) |t| t.string else return error.MissingField;
        const kind = std.meta.stringToEnum(enums.StoryAreaKind, type_str) orelse return error.UnknownType;

        return switch (kind) {
            .location => .{ .location = try std.json.innerParseFromValue(types.StoryAreaTypeLocation, allocator, value, options) },
            .suggested_reaction => .{ .suggested_reaction = try std.json.innerParseFromValue(types.StoryAreaTypeSuggestedReaction, allocator, value, options) },
            .link => .{ .link = try std.json.innerParseFromValue(types.StoryAreaTypeLink, allocator, value, options) },
            .weather => .{ .weather = try std.json.innerParseFromValue(types.StoryAreaTypeWeather, allocator, value, options) },
            .unique_gift => .{ .unique_gift = try std.json.innerParseFromValue(types.StoryAreaTypeUniqueGift, allocator, value, options) },
        };
    }
};
