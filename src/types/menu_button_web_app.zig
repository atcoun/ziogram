const enums = @import("enums");
const types = @import("../types.zig");

type: enums.MenuButtonType = .web_app,
text: []const u8,
web_app: types.WebAppInfo,
