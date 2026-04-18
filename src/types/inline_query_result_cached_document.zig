const enums = @import("../enums.zig");
const types = @import("../types.zig");

pub const InlineQueryResultCachedDocument = struct {
    type: enums.InlineQueryResultType = .document,
    id: []const u8,
    title: []const u8,
    document_file_id: []const u8,
    description: ?[]const u8 = null,
    caption: ?[]const u8 = null,
    parse_mode: ?enums.ParseMode = null,
    caption_entities: ?[]const types.MessageEntity = null,
    reply_markup: ?types.InlineKeyboardMarkup = null,
    input_message_content: ?types.InputMessageContent = null,
};
