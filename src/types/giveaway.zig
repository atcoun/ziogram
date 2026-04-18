const types = @import("../types.zig");

pub const Giveaway = struct {
    chats: []const types.Chat,
    winners_selection_date: i32,
    winner_count: i32,
    only_new_members: ?bool = null,
    has_public_winners: ?bool = null,
    prize_description: ?[]const u8 = null,
    country_codes: ?[]const []const u8 = null,
    prize_star_count: ?i32 = null,
    premium_subscription_month_count: ?i32 = null,
};
