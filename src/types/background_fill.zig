const std = @import("std");

const enums = @import("enums");
const types = @import("types");
const utils = @import("utils");

pub const BackgroundFill = union(enum) {
    solid: types.BackgroundFillSolid,
    gradient: types.BackgroundFillGradient,
    freeform_gradient: types.BackgroundFillFreeformGradient,

    const Self = @This();

    pub fn jsonParse(allocator: std.mem.Allocator, source: anytype, options: std.json.ParseOptions) !Self {
        return utils.json.parseTaggedUnion(Self, enums.BackgroundFillType, allocator, source, options);
    }
};
