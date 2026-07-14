const std = @import("std");

const enums = @import("enums");
const types = @import("types");
const utils = @import("utils");

pub const MessageOrigin = union(enum) {
    user: types.MessageOriginUser,
    hidden_user: types.MessageOriginHiddenUser,
    chat: types.MessageOriginChat,
    channel: types.MessageOriginChannel,

    const Self = @This();

    pub fn jsonParse(allocator: std.mem.Allocator, source: anytype, options: std.json.ParseOptions) !Self {
        return utils.json.parseTaggedUnion(Self, enums.MessageOriginType, allocator, source, options);
    }
};
