const enums = @import("../enums.zig");
const types = @import("../types.zig");

pub const InlineQueryResultPhoto = struct {
    type: enums.InlineQueryResultType = .photo,
    id: []const u8,
    photo_url: []const u8,
    thumbnail_url: []const u8,
    photo_width: ?i32 = null,
    photo_height: ?i32 = null,
    title: ?[]const u8 = null,
    description: ?[]const u8 = null,
    caption: ?[]const u8 = null,
    parse_mode: ?enums.ParseMode = null,
    caption_entities: ?[]const types.MessageEntity = null,
    show_caption_above_media: ?bool = null,
    reply_markup: ?types.InlineKeyboardMarkup = null,
    input_message_content: ?types.InputMessageContent = null,
};
