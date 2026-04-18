const enums = @import("../enums.zig");

pub const ReactionTypeEmoji = struct {
    type: enums.ReactionTypeKind = .emoji,
    emoji: enums.ReactionEmoji,
};
