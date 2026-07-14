const std = @import("std");

const enums = @import("enums");
const types = @import("types");
const utils = @import("utils");

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

    const Self = @This();

    pub fn jsonParse(allocator: std.mem.Allocator, source: anytype, options: std.json.ParseOptions) !Self {
        return utils.json.parseTaggedUnion(Self, enums.RichBlockType, allocator, source, options);
    }
};
