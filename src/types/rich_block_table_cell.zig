const enums = @import("enums");
const types = @import("types");

text: ?types.RichText = null,
is_header: ?bool = null,
colspan: ?i32 = null,
rowspan: ?i32 = null,
@"align": enums.HorizontalAlignment,
valign: enums.VerticalAlignment,
