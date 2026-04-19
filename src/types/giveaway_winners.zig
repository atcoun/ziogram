const types = @import("types");

chat: types.Chat,
giveaway_message_id: i32,
winners_selection_date: i32,
winner_count: i32,
winners: []const types.User,
additional_chat_count: ?i32 = null,
prize_star_count: ?i32 = null,
premium_subscription_month_count: ?i32 = null,
unclaimed_prize_count: ?i32 = null,
only_new_members: ?bool = null,
was_refunded: ?bool = null,
prize_description: ?[]const u8 = null,
