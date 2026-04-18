const enums = @import("../enums.zig");

pub const BackgroundTypeChatTheme = struct {
    type: enums.BackgroundTypeKind = .chat_theme,
    theme_name: []const u8,
};
