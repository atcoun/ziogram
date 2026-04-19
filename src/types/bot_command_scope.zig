const std = @import("std");

const enums = @import("enums");
const types = @import("types");

pub const BotCommandScope = union(enum) {
    default: types.BotCommandScopeDefault,
    all_private_chats: types.BotCommandScopeAllPrivateChats,
    all_group_chats: types.BotCommandScopeAllGroupChats,
    all_chat_administrators: types.BotCommandScopeAllChatAdministrators,
    chat: types.BotCommandScopeChat,
    chat_administrators: types.BotCommandScopeChatAdministrators,
    chat_member: types.BotCommandScopeChatMember,

    pub fn jsonParse(allocator: std.mem.Allocator, source: anytype, options: std.json.ParseOptions) !@This() {
        const value = try std.json.innerParse(std.json.Value, allocator, source, options);
        const type_str = if (value.object.get("type")) |t| t.string else return error.MissingField;
        const scope_type = std.meta.stringToEnum(enums.BotCommandScopeType, type_str) orelse return error.UnknownType;

        return switch (scope_type) {
            .default => .{ .default = try std.json.innerParseFromValue(types.BotCommandScopeDefault, allocator, value, options) },
            .all_private_chats => .{ .all_private_chats = try std.json.innerParseFromValue(types.BotCommandScopeAllPrivateChats, allocator, value, options) },
            .all_group_chats => .{ .all_group_chats = try std.json.innerParseFromValue(types.BotCommandScopeAllGroupChats, allocator, value, options) },
            .all_chat_administrators => .{ .all_chat_administrators = try std.json.innerParseFromValue(types.BotCommandScopeAllChatAdministrators, allocator, value, options) },
            .chat => .{ .chat = try std.json.innerParseFromValue(types.BotCommandScopeChat, allocator, value, options) },
            .chat_administrators => .{ .chat_administrators = try std.json.innerParseFromValue(types.BotCommandScopeChatAdministrators, allocator, value, options) },
            .chat_member => .{ .chat_member = try std.json.innerParseFromValue(types.BotCommandScopeChatMember, allocator, value, options) },
        };
    }
};
