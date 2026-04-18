const enums = @import("../enums.zig");
const types = @import("../types.zig");

pub const BotCommandScopeChatMember = struct {
    type: enums.BotCommandScopeType = .chat_member,
    chat_id: types.ChatId,
    user_id: i32,
};
