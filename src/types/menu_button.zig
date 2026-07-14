const std = @import("std");

const enums = @import("enums");
const types = @import("types");
const utils = @import("utils");

pub const MenuButton = union(enum) {
    commands: types.MenuButtonCommands,
    web_app: types.MenuButtonWebApp,
    default: types.MenuButtonDefault,

    const Self = @This();

    pub fn jsonParse(allocator: std.mem.Allocator, source: anytype, options: std.json.ParseOptions) !Self {
        return utils.json.parseTaggedUnion(Self, enums.MenuButtonType, allocator, source, options);
    }
};
