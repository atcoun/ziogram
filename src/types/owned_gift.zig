const std = @import("std");

const enums = @import("enums");
const types = @import("types");
const utils = @import("utils");

pub const OwnedGift = union(enum) {
    regular: types.OwnedGiftRegular,
    unique: types.OwnedGiftUnique,

    const Self = @This();

    pub fn jsonParse(allocator: std.mem.Allocator, source: anytype, options: std.json.ParseOptions) !Self {
        return utils.json.parseTaggedUnion(Self, enums.OwnedGiftKind, allocator, source, options);
    }
};
