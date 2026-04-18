const enums = @import("../enums.zig");

pub const Dice = struct {
    emoji: enums.DiceEmoji,
    value: i32,
};
