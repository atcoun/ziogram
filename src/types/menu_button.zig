const std = @import("std");

const enums = @import("enums");
const types = @import("types");

pub const MenuButton = union(enum) {
    commands: types.MenuButtonCommands,
    web_app: types.MenuButtonWebApp,
    default: types.MenuButtonDefault,

    pub fn jsonParse(allocator: std.mem.Allocator, source: anytype, options: std.json.ParseOptions) !@This() {
        const value = try std.json.innerParse(std.json.Value, allocator, source, options);
        const type_str = if (value.object.get("type")) |t| t.string else return error.MissingField;
        const button_type = std.meta.stringToEnum(enums.MenuButtonType, type_str) orelse return error.UnknownType;

        return switch (button_type) {
            .commands => .{ .commands = try std.json.innerParseFromValue(types.MenuButtonCommands, allocator, value, options) },
            .web_app => .{ .web_app = try std.json.innerParseFromValue(types.MenuButtonWebApp, allocator, value, options) },
            .default => .{ .default = try std.json.innerParseFromValue(types.MenuButtonDefault, allocator, value, options) },
        };
    }
};
