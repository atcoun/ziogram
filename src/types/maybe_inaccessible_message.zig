const std = @import("std");

const types = @import("../types.zig");

pub const MaybeInaccessibleMessage = union(enum) {
    message: *types.Message,
    inaccessible_message: types.InaccessibleMessage,

    pub fn jsonParseFromValue(allocator: std.mem.Allocator, source: std.json.Value, options: std.json.ParseOptions) !@This() {
        if (source != .object) return error.UnexpectedToken;
        const date = if (source.object.get("date")) |d| d.integer else 0;

        if (date == 0) {
            return .{ .inaccessible_message = try std.json.innerParseFromValue(types.InaccessibleMessage, allocator, source, options) };
        } else {
            const msg_ptr = try allocator.create(types.Message);
            errdefer allocator.destroy(msg_ptr);
            msg_ptr.* = try std.json.innerParseFromValue(types.Message, allocator, source, options);
            return .{ .message = msg_ptr };
        }
    }

    pub fn jsonParse(allocator: std.mem.Allocator, source: anytype, options: std.json.ParseOptions) !@This() {
        const value = try std.json.innerParse(std.json.Value, allocator, source, options);
        return try jsonParseFromValue(allocator, value, options);
    }
};
