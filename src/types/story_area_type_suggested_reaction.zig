const enums = @import("enums");
const types = @import("../types.zig");

type: enums.StoryAreaKind = .suggested_reaction,
reaction_type: types.ReactionType,
is_dark: ?bool = null,
is_flipped: ?bool = null,
