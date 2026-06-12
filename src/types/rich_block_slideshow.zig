const enums = @import("enums");
const types = @import("types");

type: enums.RichBlockType = .slideshow,
blocks: []const types.RichBlock,
caption: ?types.RichBlockCaption = null,
