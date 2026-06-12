const enums = @import("enums");
const types = @import("types");

type: enums.RichBlockType = .blockquote,
blocks: []const types.RichBlock,
credit: ?types.RichText = null,
