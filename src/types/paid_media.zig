const std = @import("std");

const enums = @import("enums");
const types = @import("types");

pub const PaidMedia = union(enum) {
    preview: types.PaidMediaPreview,
    photo: types.PaidMediaPhoto,
    video: types.PaidMediaVideo,

    pub fn jsonParse(allocator: std.mem.Allocator, source: anytype, options: std.json.ParseOptions) !@This() {
        const value = try std.json.innerParse(std.json.Value, allocator, source, options);
        const type_str = if (value.object.get("type")) |t| t.string else return error.MissingField;
        const media_type = std.meta.stringToEnum(enums.PaidMediaType, type_str) orelse return error.UnexpectedToken;

        return switch (media_type) {
            .preview => .{ .preview = try std.json.innerParseFromValue(types.PaidMediaPreview, allocator, value, options) },
            .photo => .{ .photo = try std.json.innerParseFromValue(types.PaidMediaPhoto, allocator, value, options) },
            .video => .{ .video = try std.json.innerParseFromValue(types.PaidMediaVideo, allocator, value, options) },
        };
    }
};
