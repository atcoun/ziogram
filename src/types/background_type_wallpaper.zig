const enums = @import("enums");
const types = @import("types");

type: enums.BackgroundTypeKind = .wallpaper,
document: types.Document,
dark_theme_dimming: i32,
is_blurred: ?bool = null,
is_moving: ?bool = null,
