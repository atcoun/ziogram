const enums = @import("../enums.zig");
const types = @import("../types.zig");

pub const InlineQueryResultLocation = struct {
    type: enums.InlineQueryResultType = .location,
    id: []const u8,
    latitude: f32,
    longitude: f32,
    title: []const u8,
    horizontal_accuracy: ?f32 = null,
    live_period: ?i32 = null,
    heading: ?i32 = null,
    proximity_alert_radius: ?i32 = null,
    reply_markup: ?types.InlineKeyboardMarkup = null,
    input_message_content: ?types.InputMessageContent = null,
    thumbnail_url: ?[]const u8 = null,
    thumbnail_width: ?i32 = null,
    thumbnail_height: ?i32 = null,
};
