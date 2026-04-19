const types = @import("../types.zig");

keyboard: []const []const types.KeyboardButton,
is_persistent: ?bool = null,
resize_keyboard: ?bool = null,
one_time_keyboard: ?bool = null,
input_field_placeholder: ?[]const u8 = null,
selective: ?bool = null,
