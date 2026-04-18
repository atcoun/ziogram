const enums = @import("../enums.zig");
const types = @import("../types.zig");

pub const MenuButtonWebApp = struct {
    type: enums.MenuButtonType = .web_app,
    text: []const u8,
    web_app: types.WebAppInfo,
};
