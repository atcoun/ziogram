const types = @import("types");

poll_message: ?types.MaybeInaccessibleMessage = null,
option_persistent_id: []const u8,
option_text: []const u8,
option_text_entities: ?[]const types.MessageEntity = null,
