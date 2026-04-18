const enums = @import("../enums.zig");

pub const ReactionTypePaid = struct {
    type: enums.ReactionTypeKind = .paid,
};
