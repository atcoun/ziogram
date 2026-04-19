const enums = @import("enums");
const types = @import("../types.zig");

type: enums.MessageEntityType,
offset: i32,
length: i32,
url: ?[]const u8 = null,
user: ?types.User = null,
language: ?[]const u8 = null,
custom_emoji_id: ?[]const u8 = null,
unix_time: ?i32 = null,
date_time_format: ?[]const u8 = null,
