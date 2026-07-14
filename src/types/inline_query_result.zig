const std = @import("std");

const enums = @import("enums");
const types = @import("types");

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

    const Self = @This();

    pub fn jsonParse(allocator: std.mem.Allocator, source: anytype, options: std.json.ParseOptions) !Self {
        const value = try std.json.innerParse(std.json.Value, allocator, source, options);

        const type_str = switch (value) {
            .object => |object| switch (object.get("type") orelse return error.MissingField) {
                .string => |s| s,
                else => return error.UnexpectedToken,
            },
            else => return error.UnexpectedToken,
        };

        const tag = std.meta.stringToEnum(enums.InlineQueryResultType, type_str) orelse
            return error.UnknownType;

        return switch (tag) {
            .audio => if (value.object.contains("audio_file_id"))
                .{
                    .cached_audio = try std.json.innerParseFromValue(types.InlineQueryResultCachedAudio, allocator, value, options),
                }
            else
                .{
                    .audio = try std.json.innerParseFromValue(types.InlineQueryResultAudio, allocator, value, options),
                },

            .document => if (value.object.contains("document_file_id"))
                .{
                    .cached_document = try std.json.innerParseFromValue(types.InlineQueryResultCachedDocument, allocator, value, options),
                }
            else
                .{
                    .document = try std.json.innerParseFromValue(types.InlineQueryResultDocument, allocator, value, options),
                },

            .gif => if (value.object.contains("gif_file_id"))
                .{
                    .cached_gif = try std.json.innerParseFromValue(types.InlineQueryResultCachedGif, allocator, value, options),
                }
            else
                .{
                    .gif = try std.json.innerParseFromValue(types.InlineQueryResultGif, allocator, value, options),
                },

            .mpeg4_gif => if (value.object.contains("mpeg4_file_id"))
                .{
                    .cached_mpeg4_gif = try std.json.innerParseFromValue(types.InlineQueryResultCachedMpeg4Gif, allocator, value, options),
                }
            else
                .{
                    .mpeg4_gif = try std.json.innerParseFromValue(types.InlineQueryResultMpeg4Gif, allocator, value, options),
                },

            .photo => if (value.object.contains("photo_file_id"))
                .{
                    .cached_photo = try std.json.innerParseFromValue(types.InlineQueryResultCachedPhoto, allocator, value, options),
                }
            else
                .{
                    .photo = try std.json.innerParseFromValue(types.InlineQueryResultPhoto, allocator, value, options),
                },

            .sticker => .{
                .cached_sticker = try std.json.innerParseFromValue(types.InlineQueryResultCachedSticker, allocator, value, options),
            },

            .video => if (value.object.contains("video_file_id"))
                .{
                    .cached_video = try std.json.innerParseFromValue(types.InlineQueryResultCachedVideo, allocator, value, options),
                }
            else
                .{
                    .video = try std.json.innerParseFromValue(types.InlineQueryResultVideo, allocator, value, options),
                },

            .voice => if (value.object.contains("voice_file_id"))
                .{
                    .cached_voice = try std.json.innerParseFromValue(types.InlineQueryResultCachedVoice, allocator, value, options),
                }
            else
                .{
                    .voice = try std.json.innerParseFromValue(types.InlineQueryResultVoice, allocator, value, options),
                },

            .article => .{
                .article = try std.json.innerParseFromValue(types.InlineQueryResultArticle, allocator, value, options),
            },

            .contact => .{
                .contact = try std.json.innerParseFromValue(types.InlineQueryResultContact, allocator, value, options),
            },

            .game => .{
                .game = try std.json.innerParseFromValue(types.InlineQueryResultGame, allocator, value, options),
            },

            .location => .{
                .location = try std.json.innerParseFromValue(types.InlineQueryResultLocation, allocator, value, options),
            },

            .venue => .{
                .venue = try std.json.innerParseFromValue(types.InlineQueryResultVenue, allocator, value, options),
            },
        };
    }
};
