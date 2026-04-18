const enums = @import("../enums.zig");
const types = @import("../types.zig");

pub const StoryAreaTypeSuggestedReaction = struct {
    type: enums.StoryAreaKind = .suggested_reaction,
    reaction_type: types.ReactionType,
    is_dark: ?bool = null,
    is_flipped: ?bool = null,
};
