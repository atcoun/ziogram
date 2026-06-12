const types = @import("types");
const enums = @import("enums");

label: []const u8,
blocks: []const types.RichBlock,
has_checkbox: ?bool = null,
is_checked: ?bool = null,
value: ?i32 = null,
type: ?enums.RichBlockListItemType = null,
