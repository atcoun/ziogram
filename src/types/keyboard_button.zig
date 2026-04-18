const enums = @import("../enums.zig");
const types = @import("../types.zig");

pub const KeyboardButton = struct {
    text: []const u8,
    icon_custom_emoji_id: ?[]const u8 = null,
    style: ?enums.KeyboardButtonStyle = null,
    request_users: ?types.KeyboardButtonRequestUsers = null,
    request_chat: ?types.KeyboardButtonRequestChat = null,
    request_managed_bot: ?types.KeyboardButtonRequestManagedBot = null,
    request_contact: ?bool = null,
    request_location: ?bool = null,
    request_poll: ?types.KeyboardButtonPollType = null,
    web_app: ?types.WebAppInfo = null,
};
