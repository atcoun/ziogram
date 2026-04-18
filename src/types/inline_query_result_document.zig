const enums = @import("../enums.zig");
const types = @import("../types.zig");

pub const InlineQueryResultDocument = struct {
    type: enums.InlineQueryResultType = .document,
    id: []const u8,
    title: []const u8,
    caption: ?[]const u8 = null,
    parse_mode: ?enums.ParseMode = null,
    caption_entities: ?[]const types.MessageEntity = null,
    document_url: []const u8,
    mime_type: []const u8,
    description: ?[]const u8 = null,
    reply_markup: ?types.InlineKeyboardMarkup = null,
    input_message_content: ?types.InputMessageContent = null,
    thumbnail_url: ?[]const u8 = null,
    thumbnail_width: ?i32 = null,
    thumbnail_height: ?i32 = null,
};
