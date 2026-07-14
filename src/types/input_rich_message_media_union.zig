const std = @import("std");

const enums = @import("enums");
const types = @import("types");
const utils = @import("utils");

pub const InputRichMessageMediaUnion = union(enum) {
    animation: types.InputMediaAnimation,
    audio: types.InputMediaAudio,
    photo: types.InputMediaPhoto,
    video: types.InputMediaVideo,
    voice_note: types.InputMediaVoiceNote,

    const Self = @This();

    pub fn jsonParse(allocator: std.mem.Allocator, source: anytype, options: std.json.ParseOptions) !Self {
        return utils.json.parseTaggedUnion(Self, enums.InputRichMessageMediaType, allocator, source, options);
    }
};
