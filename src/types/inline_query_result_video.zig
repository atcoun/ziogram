const enums = @import("../enums.zig");
const types = @import("../types.zig");

pub const InlineQueryResultVideo = struct {
    type: enums.InlineQueryResultType = .video,
    id: []const u8,
    video_url: []const u8,
    mime_type: []const u8,
    thumbnail_url: []const u8,
    title: []const u8,
    caption: ?[]const u8 = null,
    parse_mode: ?enums.ParseMode = null,
    caption_entities: ?[]const types.MessageEntity = null,
    show_caption_above_media: ?bool = null,
    video_width: ?i32 = null,
    video_height: ?i32 = null,
    video_duration: ?i32 = null,
    description: ?[]const u8 = null,
    reply_markup: ?types.InlineKeyboardMarkup = null,
    input_message_content: ?types.InputMessageContent = null,
};
