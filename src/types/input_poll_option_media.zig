const std = @import("std");

const enums = @import("enums");
const types = @import("types");

pub const InputPollOptionMedia = union(enum) {
    animation: types.InputMediaAnimation,
    live_photo: types.InputMediaLivePhoto,
    location: types.InputMediaLocation,
    photo: types.InputMediaPhoto,
    sticker: types.InputMediaSticker,
    venue: types.InputMediaVenue,
    video: types.InputMediaVideo,

    pub fn jsonParse(allocator: std.mem.Allocator, source: anytype, options: std.json.ParseOptions) !@This() {
        const value = try std.json.innerParse(std.json.Value, allocator, source, options);
        const type_str = if (value.object.get("type")) |t| t.string else return error.MissingField;
        const poll_option_media_type = std.meta.stringToEnum(enums.InputPollOptionMediaType, type_str) orelse return error.UnknownType;

        return switch (poll_option_media_type) {
            .animation => .{ .animation = try std.json.innerParseFromValue(types.InputMediaAnimation, allocator, value, options) },
            .live_photo => .{ .live_photo = try std.json.innerParseFromValue(types.InputMediaLivePhoto, allocator, value, options) },
            .location => .{ .location = try std.json.innerParseFromValue(types.InputMediaLocation, allocator, value, options) },
            .photo => .{ .photo = try std.json.innerParseFromValue(types.InputMediaPhoto, allocator, value, options) },
            .sticker => .{ .sticker = try std.json.innerParseFromValue(types.InputMediaSticker, allocator, value, options) },
            .venue => .{ .venue = try std.json.innerParseFromValue(types.InputMediaVenue, allocator, value, options) },
            .video => .{ .video = try std.json.innerParseFromValue(types.InputMediaVideo, allocator, value, options) },
        };
    }
};
