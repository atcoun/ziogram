const enums = @import("enums");
const types = @import("types");

type: enums.InputRichBlockType = .slideshow,
blocks: []const types.InputRichBlock,
caption: ?types.RichBlockCaption = null,
