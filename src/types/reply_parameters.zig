const enums = @import("enums");
const types = @import("../types.zig");

message_id: i32,
chat_id: ?types.ChatId = null,
allow_sending_without_reply: ?bool = null,
quote: ?[]const u8 = null,
quote_parse_mode: ?enums.ParseMode = null,
quote_entities: ?[]const types.MessageEntity = null,
quote_position: ?i32 = null,
checklist_task_id: ?i32 = null,
poll_option_id: ?[]const u8 = null,
