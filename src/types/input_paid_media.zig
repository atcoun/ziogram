const std = @import("std");

const enums = @import("../enums.zig");
const types = @import("../types.zig");

pub const InputPaidMedia = union(enum) {
    photo: types.InputPaidMediaPhoto,
    video: types.InputPaidMediaVideo,

    pub fn jsonParse(allocator: std.mem.Allocator, source: anytype, options: std.json.ParseOptions) !@This() {
        const value = try std.json.innerParse(std.json.Value, allocator, source, options);
        const type_str = if (value.object.get("type")) |t| t.string else return error.MissingField;
        const paid_media_type = std.meta.stringToEnum(enums.InputPaidMediaType, type_str) orelse return error.UnknownType;

        return switch (paid_media_type) {
            .photo => .{ .photo = try std.json.innerParseFromValue(types.InputPaidMediaPhoto, allocator, value, options) },
            .video => .{ .video = try std.json.innerParseFromValue(types.InputPaidMediaVideo, allocator, value, options) },
        };
    }
};
