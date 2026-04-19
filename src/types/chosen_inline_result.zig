const types = @import("../types.zig");

result_id: []const u8,
from: types.User,
location: ?types.Location = null,
inline_message_id: ?[]const u8 = null,
query: []const u8,
