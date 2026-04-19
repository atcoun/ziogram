const std = @import("std");

const enums = @import("enums");
const types = @import("../types.zig");

pub const ReactionType = union(enum) {
    emoji: types.ReactionTypeEmoji,
    custom_emoji: types.ReactionTypeCustomEmoji,
    paid: types.ReactionTypePaid,

    pub fn jsonParse(allocator: std.mem.Allocator, source: anytype, options: std.json.ParseOptions) !@This() {
        const value = try std.json.innerParse(std.json.Value, allocator, source, options);
        const type_str = if (value.object.get("type")) |t| t.string else return error.MissingField;
        const kind = std.meta.stringToEnum(enums.ReactionTypeKind, type_str) orelse return error.UnexpectedToken;

        return switch (kind) {
            .emoji => .{ .emoji = try std.json.innerParseFromValue(types.ReactionTypeEmoji, allocator, value, options) },
            .custom_emoji => .{ .custom_emoji = try std.json.innerParseFromValue(types.ReactionTypeCustomEmoji, allocator, value, options) },
            .paid => .{ .paid = try std.json.innerParseFromValue(types.ReactionTypePaid, allocator, value, options) },
        };
    }
};
