const std = @import("std");

const enums = @import("enums");
const types = @import("types");
const utils = @import("utils");

pub const ChatBoostSource = union(enum) {
    premium: types.ChatBoostSourcePremium,
    gift_code: types.ChatBoostSourceGiftCode,
    giveaway: types.ChatBoostSourceGiveaway,

    const Self = @This();

    pub fn jsonParse(allocator: std.mem.Allocator, source: anytype, options: std.json.ParseOptions) !Self {
        return utils.json.parseTaggedUnion(Self, enums.ChatBoostSourceType, allocator, source, options);
    }
};
