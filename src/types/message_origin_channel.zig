const enums = @import("enums");
const types = @import("../types.zig");

type: enums.MessageOriginType = .channel,
date: i32,
chat: types.Chat,
message_id: i32,
author_signature: ?[]const u8 = null,
