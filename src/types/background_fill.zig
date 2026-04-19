const std = @import("std");

const enums = @import("enums");
const types = @import("types");

pub const BackgroundFill = union(enum) {
    solid: types.BackgroundFillSolid,
    gradient: types.BackgroundFillGradient,
    freeform_gradient: types.BackgroundFillFreeformGradient,

    pub fn jsonParse(allocator: std.mem.Allocator, source: anytype, options: std.json.ParseOptions) !@This() {
        const value = try std.json.innerParse(std.json.Value, allocator, source, options);
        const type_str = if (value.object.get("type")) |t| t.string else return error.MissingField;
        const fill_type = std.meta.stringToEnum(enums.BackgroundFillType, type_str) orelse return error.UnknownType;

        return switch (fill_type) {
            .solid => .{ .solid = try std.json.innerParseFromValue(types.BackgroundFillSolid, allocator, value, options) },
            .gradient => .{ .gradient = try std.json.innerParseFromValue(types.BackgroundFillGradient, allocator, value, options) },
            .freeform_gradient => .{ .freeform_gradient = try std.json.innerParseFromValue(types.BackgroundFillFreeformGradient, allocator, value, options) },
        };
    }
};
