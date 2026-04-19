const std = @import("std");

const enums = @import("enums");
const types = @import("../types.zig");

pub const InputMedia = union(enum) {
    animation: types.InputMediaAnimation,
    document: types.InputMediaDocument,
    audio: types.InputMediaAudio,
    photo: types.InputMediaPhoto,
    video: types.InputMediaVideo,

    pub fn jsonParse(allocator: std.mem.Allocator, source: anytype, options: std.json.ParseOptions) !@This() {
        const value = try std.json.innerParse(std.json.Value, allocator, source, options);
        const type_str = if (value.object.get("type")) |t| t.string else return error.MissingField;
        const media_type = std.meta.stringToEnum(enums.InputMediaType, type_str) orelse return error.UnknownType;

        return switch (media_type) {
            .animation => .{ .animation = try std.json.innerParseFromValue(types.InputMediaAnimation, allocator, value, options) },
            .document => .{ .document = try std.json.innerParseFromValue(types.InputMediaDocument, allocator, value, options) },
            .audio => .{ .audio = try std.json.innerParseFromValue(types.InputMediaAudio, allocator, value, options) },
            .photo => .{ .photo = try std.json.innerParseFromValue(types.InputMediaPhoto, allocator, value, options) },
            .video => .{ .video = try std.json.innerParseFromValue(types.InputMediaVideo, allocator, value, options) },
        };
    }
};
