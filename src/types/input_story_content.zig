const std = @import("std");

const enums = @import("../enums.zig");
const types = @import("../types.zig");

pub const InputStoryContent = union(enum) {
    photo: types.InputStoryContentPhoto,
    video: types.InputStoryContentVideo,

    pub fn jsonParse(allocator: std.mem.Allocator, source: anytype, options: std.json.ParseOptions) !@This() {
        const value = try std.json.innerParse(std.json.Value, allocator, source, options);
        const type_str = if (value.object.get("type")) |t| t.string else return error.MissingField;
        const content_type = std.meta.stringToEnum(enums.InputStoryContentType, type_str) orelse return error.UnknownType;

        return switch (content_type) {
            .photo => .{ .photo = try std.json.innerParseFromValue(types.InputStoryContentPhoto, allocator, value, options) },
            .video => .{ .video = try std.json.innerParseFromValue(types.InputStoryContentVideo, allocator, value, options) },
        };
    }
};
