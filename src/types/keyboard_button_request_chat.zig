const types = @import("../types.zig");

pub const KeyboardButtonRequestChat = struct {
    request_id: i32,
    chat_is_channel: bool,
    chat_is_forum: ?bool = null,
    chat_has_username: ?bool = null,
    chat_is_created: ?bool = null,
    user_administrator_rights: ?types.ChatAdministratorRights = null,
    bot_administrator_rights: ?types.ChatAdministratorRights = null,
    bot_is_member: ?bool = null,
    request_title: ?bool = null,
    request_username: ?bool = null,
    request_photo: ?bool = null,
};
