const std = @import("std");

const enums = @import("enums");
const types = @import("types");
const utils = @import("utils");

pub const ReactionType = union(enum) {
    emoji: types.ReactionTypeEmoji,
    custom_emoji: types.ReactionTypeCustomEmoji,
    paid: types.ReactionTypePaid,

    const Self = @This();

    pub fn jsonParse(allocator: std.mem.Allocator, source: anytype, options: std.json.ParseOptions) !Self {
        return utils.json.parseTaggedUnion(Self, enums.ReactionTypeKind, allocator, source, options);
    }
};
