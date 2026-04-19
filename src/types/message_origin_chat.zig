const enums = @import("enums");
const types = @import("types");

type: enums.MessageOriginType = .chat,
date: i32,
sender_chat: types.Chat,
author_signature: ?[]const u8 = null,
