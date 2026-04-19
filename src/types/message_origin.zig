const std = @import("std");

const enums = @import("enums");
const types = @import("types");

pub const MessageOrigin = union(enum) {
    user: types.MessageOriginUser,
    hidden_user: types.MessageOriginHiddenUser,
    chat: types.MessageOriginChat,
    channel: types.MessageOriginChannel,

    pub fn jsonParse(allocator: std.mem.Allocator, source: anytype, options: std.json.ParseOptions) !@This() {
        const value = try std.json.innerParse(std.json.Value, allocator, source, options);
        const type_str = if (value.object.get("type")) |t| t.string else return error.MissingField;
        const origin_type = std.meta.stringToEnum(enums.MessageOriginType, type_str) orelse return error.UnexpectedToken;

        return switch (origin_type) {
            .user => .{ .user = try std.json.innerParseFromValue(types.MessageOriginUser, allocator, value, options) },
            .hidden_user => .{ .hidden_user = try std.json.innerParseFromValue(types.MessageOriginHiddenUser, allocator, value, options) },
            .chat => .{ .chat = try std.json.innerParseFromValue(types.MessageOriginChat, allocator, value, options) },
            .channel => .{ .channel = try std.json.innerParseFromValue(types.MessageOriginChannel, allocator, value, options) },
        };
    }
};
