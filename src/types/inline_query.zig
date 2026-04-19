const enums = @import("enums");
const types = @import("types");

id: []const u8,
from: types.User,
query: []const u8,
offset: []const u8,
chat_type: ?enums.InlineQueryChatType = null,
location: ?types.Location = null,
