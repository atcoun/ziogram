const enums = @import("enums");
const types = @import("types");

type: enums.BackgroundTypeKind = .pattern,
document: types.Document,
fill: types.BackgroundFill,
intensity: i32,
is_inverted: ?bool = null,
is_moving: ?bool = null,
