pub const BotCommandScopeType = enum {
    default,
    all_private_chats,
    all_group_chats,
    all_chat_administrators,
    chat,
    chat_administrators,
    chat_member,
};
