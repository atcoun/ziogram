const std = @import("std");

const enums = @import("enums");
const types = @import("types");
const utils = @import("utils");

pub const InputRichBlock = union(enum) {
    paragraph: types.InputRichBlockParagraph,
    section_heading: types.InputRichBlockSectionHeading,
    preformatted: types.InputRichBlockPreformatted,
    footer: types.InputRichBlockFooter,
    divider: types.InputRichBlockDivider,
    mathematical_expression: types.InputRichBlockMathematicalExpression,
    anchor: types.InputRichBlockAnchor,
    list: types.InputRichBlockList,
    block_quotation: types.InputRichBlockBlockQuotation,
    pull_quotation: types.InputRichBlockPullQuotation,
    collage: types.InputRichBlockCollage,
    slideshow: types.InputRichBlockSlideshow,
    table: types.InputRichBlockTable,
    details: types.InputRichBlockDetails,
    map: types.InputRichBlockMap,
    animation: types.InputRichBlockAnimation,
    audio: types.InputRichBlockAudio,
    photo: types.InputRichBlockPhoto,
    video: types.InputRichBlockVideo,
    voice_note: types.InputRichBlockVoiceNote,
    thinking: types.InputRichBlockThinking,

    const Self = @This();

    pub fn jsonParse(allocator: std.mem.Allocator, source: anytype, options: std.json.ParseOptions) !Self {
        return utils.json.parseTaggedUnion(Self, enums.InputRichBlockType, allocator, source, options);
    }
};
