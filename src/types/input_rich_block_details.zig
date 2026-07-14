const enums = @import("enums");
const types = @import("types");

type: enums.InputRichBlockType = .details,
summary: types.RichText,
blocks: []const types.InputRichBlock,
is_open: ?bool = null,
