const std = @import("std");

const enums = @import("enums");
const types = @import("../types.zig");

pub const ChatBoostSource = union(enum) {
    premium: types.ChatBoostSourcePremium,
    gift_code: types.ChatBoostSourceGiftCode,
    giveaway: types.ChatBoostSourceGiveaway,

    pub fn jsonParse(allocator: std.mem.Allocator, source: anytype, options: std.json.ParseOptions) !@This() {
        const value = try std.json.innerParse(std.json.Value, allocator, source, options);
        const source_str = if (value.object.get("source")) |s| s.string else return error.MissingField;
        const boost_source = std.meta.stringToEnum(enums.ChatBoostSourceType, source_str) orelse return error.UnexpectedToken;

        return switch (boost_source) {
            .premium => .{ .premium = try std.json.innerParseFromValue(types.ChatBoostSourcePremium, allocator, value, options) },
            .gift_code => .{ .gift_code = try std.json.innerParseFromValue(types.ChatBoostSourceGiftCode, allocator, value, options) },
            .giveaway => .{ .giveaway = try std.json.innerParseFromValue(types.ChatBoostSourceGiveaway, allocator, value, options) },
        };
    }
};
