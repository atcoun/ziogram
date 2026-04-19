const enums = @import("enums");

id: i64,
type: enums.ChatType,
title: ?[]const u8 = null,
username: ?[]const u8 = null,
first_name: ?[]const u8 = null,
last_name: ?[]const u8 = null,
is_forum: ?bool = null,
is_direct_messages: ?bool = null,
