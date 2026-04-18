const std = @import("std");

const enums = @import("../enums.zig");
const types = @import("../types.zig");

pub const InlineQueryResult = union(enum) {
    cached_audio: types.InlineQueryResultCachedAudio,
    cached_document: types.InlineQueryResultCachedDocument,
    cached_gif: types.InlineQueryResultCachedGif,
    cached_mpeg4_gif: types.InlineQueryResultCachedMpeg4Gif,
    cached_photo: types.InlineQueryResultCachedPhoto,
    cached_sticker: types.InlineQueryResultCachedSticker,
    cached_video: types.InlineQueryResultCachedVideo,
    cached_voice: types.InlineQueryResultCachedVoice,
    article: types.InlineQueryResultArticle,
    audio: types.InlineQueryResultAudio,
    contact: types.InlineQueryResultContact,
    game: types.InlineQueryResultGame,
    document: types.InlineQueryResultDocument,
    gif: types.InlineQueryResultGif,
    location: types.InlineQueryResultLocation,
    mpeg4_gif: types.InlineQueryResultMpeg4Gif,
    photo: types.InlineQueryResultPhoto,
    venue: types.InlineQueryResultVenue,
    video: types.InlineQueryResultVideo,
    voice: types.InlineQueryResultVoice,

    pub fn jsonParse(allocator: std.mem.Allocator, source: anytype, options: std.json.ParseOptions) !@This() {
        const value = try std.json.innerParse(std.json.Value, allocator, source, options);
        const type_str = if (value.object.get("type")) |t| t.string else return error.MissingField;

        _ = type_str;
        return error.NotImplemented;
    }
};
