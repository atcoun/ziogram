const enums = @import("enums");
const types = @import("../types.zig");

text: []const u8,
icon_custom_emoji_id: ?[]const u8 = null,
style: ?enums.KeyboardButtonStyle = null,
url: ?[]const u8 = null,
callback_data: ?[]const u8 = null,
web_app: ?types.WebAppInfo = null,
login_url: ?types.LoginUrl = null,
switch_inline_query: ?[]const u8 = null,
switch_inline_query_current_chat: ?[]const u8 = null,
switch_inline_query_chosen_chat: ?types.SwitchInlineQueryChosenChat = null,
copy_text: ?types.CopyTextButton = null,
callback_game: ?types.CallbackGame = null,
pay: ?bool = null,
