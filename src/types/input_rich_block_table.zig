const enums = @import("enums");
const types = @import("types");

type: enums.InputRichBlockType = .table,
cells: []const []const types.RichBlockTableCell,
is_bordered: ?bool = null,
is_striped: ?bool = null,
caption: ?types.RichText = null,
