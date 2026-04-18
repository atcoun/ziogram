const enums = @import("../enums.zig");
const types = @import("../types.zig");

pub const InputPollOption = struct {
    text: []const u8,
    text_parse_mode: ?enums.ParseMode = null,
    text_entities: ?[]const types.MessageEntity = null,
};
