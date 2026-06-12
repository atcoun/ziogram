const std = @import("std");

const enums = @import("enums");
const types = @import("types");

pub const RichBlock = union(enum) {
    paragraph: types.RichBlockParagraph,
    heading: types.RichBlockSectionHeading,
    pre: types.RichBlockPreformatted,
    footer: types.RichBlockFooter,
    divider: types.RichBlockDivider,
    mathematical_expression: types.RichBlockMathematicalExpression,
    anchor: types.RichBlockAnchor,
    list: types.RichBlockList,
    blockquote: types.RichBlockBlockQuotation,
    pullquote: types.RichBlockPullQuotation,
    collage: types.RichBlockCollage,
    slideshow: types.RichBlockSlideshow,
    table: types.RichBlockTable,
    details: types.RichBlockDetails,
    map: types.RichBlockMap,
    animation: types.RichBlockAnimation,
    audio: types.RichBlockAudio,
    photo: types.RichBlockPhoto,
    video: types.RichBlockVideo,
    voice_note: types.RichBlockVoiceNote,
    thinking: types.RichBlockThinking,

    pub fn jsonParse(allocator: std.mem.Allocator, source: anytype, options: std.json.ParseOptions) !@This() {
        const value = try std.json.innerParse(std.json.Value, allocator, source, options);

        const rich_type = std.meta.stringToEnum(
            enums.RichBlockType,
            if (value.object.get("type")) |t| t.string else return error.MissingField,
        ) orelse return error.UnexpectedToken;

        return switch (rich_type) {
            .paragraph => .{ .paragraph = try std.json.innerParseFromValue(types.RichBlockParagraph, allocator, value, options) },
            .heading => .{ .heading = try std.json.innerParseFromValue(types.RichBlockSectionHeading, allocator, value, options) },
            .pre => .{ .pre = try std.json.innerParseFromValue(types.RichBlockPreformatted, allocator, value, options) },
            .footer => .{ .footer = try std.json.innerParseFromValue(types.RichBlockFooter, allocator, value, options) },
            .divider => .{ .divider = try std.json.innerParseFromValue(types.RichBlockDivider, allocator, value, options) },
            .mathematical_expression => .{ .mathematical_expression = try std.json.innerParseFromValue(types.RichBlockMathematicalExpression, allocator, value, options) },
            .anchor => .{ .anchor = try std.json.innerParseFromValue(types.RichBlockAnchor, allocator, value, options) },
            .list => .{ .list = try std.json.innerParseFromValue(types.RichBlockList, allocator, value, options) },
            .blockquote => .{ .blockquote = try std.json.innerParseFromValue(types.RichBlockBlockQuotation, allocator, value, options) },
            .pullquote => .{ .pullquote = try std.json.innerParseFromValue(types.RichBlockPullQuotation, allocator, value, options) },
            .collage => .{ .collage = try std.json.innerParseFromValue(types.RichBlockCollage, allocator, value, options) },
            .slideshow => .{ .slideshow = try std.json.innerParseFromValue(types.RichBlockSlideshow, allocator, value, options) },
            .table => .{ .table = try std.json.innerParseFromValue(types.RichBlockTable, allocator, value, options) },
            .details => .{ .details = try std.json.innerParseFromValue(types.RichBlockDetails, allocator, value, options) },
            .map => .{ .map = try std.json.innerParseFromValue(types.RichBlockMap, allocator, value, options) },
            .animation => .{ .animation = try std.json.innerParseFromValue(types.RichBlockAnimation, allocator, value, options) },
            .audio => .{ .audio = try std.json.innerParseFromValue(types.RichBlockAudio, allocator, value, options) },
            .photo => .{ .photo = try std.json.innerParseFromValue(types.RichBlockPhoto, allocator, value, options) },
            .video => .{ .video = try std.json.innerParseFromValue(types.RichBlockVideo, allocator, value, options) },
            .voice_note => .{ .voice_note = try std.json.innerParseFromValue(types.RichBlockVoiceNote, allocator, value, options) },
            .thinking => .{ .thinking = try std.json.innerParseFromValue(types.RichBlockThinking, allocator, value, options) },
        };
    }
};
