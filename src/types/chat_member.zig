const std = @import("std");

const enums = @import("enums");
const types = @import("types");
const utils = @import("utils");

pub const ChatMember = union(enum) {
    owner: types.ChatMemberOwner,
    administrator: types.ChatMemberAdministrator,
    member: types.ChatMemberMember,
    restricted: types.ChatMemberRestricted,
    left: types.ChatMemberLeft,
    banned: types.ChatMemberBanned,

    const Self = @This();

    pub fn jsonParse(allocator: std.mem.Allocator, source: anytype, options: std.json.ParseOptions) !Self {
        return utils.json.parseTaggedUnion(Self, enums.ChatMemberStatus, allocator, source, options);
    }
};
