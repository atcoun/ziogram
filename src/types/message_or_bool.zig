const std = @import("std");
const types = @import("types");

pub const MessageOrBool = union(enum) {
    message: types.Message,
    success: bool,

    pub fn jsonParse(allocator: std.mem.Allocator, source: anytype, options: std.json.ParseOptions) !@This() {
        const value = try std.json.Value.jsonParse(allocator, source, options);

        return switch (value) {
            .bool => |b| .{ .success = b },
            .object => .{
                .message = try std.json.parseFromValueLeaky(types.Message, allocator, value, options),
            },
            else => error.UnexpectedToken,
        };
    }
};
