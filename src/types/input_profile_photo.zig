const std = @import("std");

const enums = @import("../enums.zig");
const types = @import("../types.zig");

pub const InputProfilePhoto = union(enum) {
    static: types.InputProfilePhotoStatic,
    animated: types.InputProfilePhotoAnimated,

    pub fn jsonParse(allocator: std.mem.Allocator, source: anytype, options: std.json.ParseOptions) !@This() {
        const value = try std.json.innerParse(std.json.Value, allocator, source, options);
        const type_str = if (value.object.get("type")) |t| t.string else return error.MissingField;
        const profile_photo_type = std.meta.stringToEnum(enums.InputProfilePhotoType, type_str) orelse return error.UnknownType;

        return switch (profile_photo_type) {
            .static => .{ .static = try std.json.innerParseFromValue(types.InputProfilePhotoStatic, allocator, value, options) },
            .animated => .{ .animated = try std.json.innerParseFromValue(types.InputProfilePhotoAnimated, allocator, value, options) },
        };
    }
};
