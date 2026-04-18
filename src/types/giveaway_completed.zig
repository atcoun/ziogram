const types = @import("../types.zig");

pub const GiveawayCompleted = struct {
    winner_count: i32,
    unclaimed_prize_count: ?i32 = null,
    giveaway_message: ?*types.Message = null,
    is_star_giveaway: ?bool = null,
};
