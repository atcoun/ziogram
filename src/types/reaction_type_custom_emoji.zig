const enums = @import("../enums.zig");

pub const ReactionTypeCustomEmoji = struct {
    type: enums.ReactionTypeKind = .custom_emoji,
    custom_emoji_id: []const u8,
};
