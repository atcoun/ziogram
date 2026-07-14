const std = @import("std");

const enums = @import("enums");
const types = @import("types");
const utils = @import("utils");

pub const BotCommandScope = union(enum) {
    default: types.BotCommandScopeDefault,
    all_private_chats: types.BotCommandScopeAllPrivateChats,
    all_group_chats: types.BotCommandScopeAllGroupChats,
    all_chat_administrators: types.BotCommandScopeAllChatAdministrators,
    chat: types.BotCommandScopeChat,
    chat_administrators: types.BotCommandScopeChatAdministrators,
    chat_member: types.BotCommandScopeChatMember,

    const Self = @This();

    pub fn jsonParse(allocator: std.mem.Allocator, source: anytype, options: std.json.ParseOptions) !Self {
        return utils.json.parseTaggedUnion(Self, enums.BotCommandScopeType, allocator, source, options);
    }
};
