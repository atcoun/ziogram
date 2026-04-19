const std = @import("std");

const enums = @import("enums");
const types = @import("../types.zig");

pub const OwnedGift = union(enum) {
    regular: types.OwnedGiftRegular,
    unique: types.OwnedGiftUnique,

    pub fn jsonParse(allocator: std.mem.Allocator, source: anytype, options: std.json.ParseOptions) !@This() {
        const value = try std.json.innerParse(std.json.Value, allocator, source, options);
        const type_str = if (value.object.get("type")) |t| t.string else return error.MissingField;
        const kind = std.meta.stringToEnum(enums.OwnedGiftKind, type_str) orelse return error.UnknownType;

        return switch (kind) {
            .regular => .{ .regular = try std.json.innerParseFromValue(types.OwnedGiftRegular, allocator, value, options) },
            .unique => .{ .unique = try std.json.innerParseFromValue(types.OwnedGiftUnique, allocator, value, options) },
        };
    }
};
