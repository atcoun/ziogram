const std = @import("std");

const enums = @import("enums");
const types = @import("types");

pub const ChatMember = union(enum) {
    owner: types.ChatMemberOwner,
    administrator: types.ChatMemberAdministrator,
    member: types.ChatMemberMember,
    restricted: types.ChatMemberRestricted,
    left: types.ChatMemberLeft,
    banned: types.ChatMemberBanned,

    pub fn jsonParse(allocator: std.mem.Allocator, source: anytype, options: std.json.ParseOptions) !@This() {
        const value = try std.json.innerParse(std.json.Value, allocator, source, options);
        const status_str = if (value.object.get("status")) |s| s.string else return error.MissingField;
        const status = std.meta.stringToEnum(enums.ChatMemberStatus, status_str) orelse return error.UnexpectedToken;

        return switch (status) {
            .creator => .{ .owner = try std.json.innerParseFromValue(types.ChatMemberOwner, allocator, value, options) },
            .administrator => .{ .administrator = try std.json.innerParseFromValue(types.ChatMemberAdministrator, allocator, value, options) },
            .member => .{ .member = try std.json.innerParseFromValue(types.ChatMemberMember, allocator, value, options) },
            .restricted => .{ .restricted = try std.json.innerParseFromValue(types.ChatMemberRestricted, allocator, value, options) },
            .left => .{ .left = try std.json.innerParseFromValue(types.ChatMemberLeft, allocator, value, options) },
            .kicked => .{ .banned = try std.json.innerParseFromValue(types.ChatMemberBanned, allocator, value, options) },
        };
    }
};
