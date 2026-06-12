const enums = @import("enums");
const types = @import("types");

type: enums.RichBlockType = .details,
summary: types.RichText,
blocks: []const types.RichBlock,
is_open: ?bool = null,
