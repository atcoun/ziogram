const std = @import("std");

const enums = @import("enums");
const types = @import("types");
const utils = @import("utils");

pub const InputMedia = union(enum) {
    animation: types.InputMediaAnimation,
    audio: types.InputMediaAudio,
    document: types.InputMediaDocument,
    live_photo: types.InputMediaLivePhoto,
    photo: types.InputMediaPhoto,
    video: types.InputMediaVideo,

    const Self = @This();

    pub fn jsonParse(allocator: std.mem.Allocator, source: anytype, options: std.json.ParseOptions) !Self {
        return utils.json.parseTaggedUnion(Self, enums.InputMediaType, allocator, source, options);
    }
};
