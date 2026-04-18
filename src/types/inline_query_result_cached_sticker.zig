const enums = @import("../enums.zig");
const types = @import("../types.zig");

pub const InlineQueryResultCachedSticker = struct {
    type: enums.InlineQueryResultType = .sticker,
    id: []const u8,
    sticker_file_id: []const u8,
    reply_markup: ?types.InlineKeyboardMarkup = null,
    input_message_content: ?types.InputMessageContent = null,
};
