const enums = @import("../enums.zig");
const types = @import("../types.zig");

pub const InlineQueryResultVenue = struct {
    type: enums.InlineQueryResultType = .venue,
    id: []const u8,
    latitude: f32,
    longitude: f32,
    title: []const u8,
    address: []const u8,
    foursquare_id: ?[]const u8 = null,
    foursquare_type: ?[]const u8 = null,
    google_place_id: ?[]const u8 = null,
    google_place_type: ?[]const u8 = null,
    reply_markup: ?types.InlineKeyboardMarkup = null,
    input_message_content: ?types.InputMessageContent = null,
    thumbnail_url: ?[]const u8 = null,
    thumbnail_width: ?i32 = null,
    thumbnail_height: ?i32 = null,
};
