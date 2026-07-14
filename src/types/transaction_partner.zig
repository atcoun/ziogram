const std = @import("std");

const enums = @import("enums");
const types = @import("types");
const utils = @import("utils");

pub const TransactionPartner = union(enum) {
    user: types.TransactionPartnerUser,
    chat: types.TransactionPartnerChat,
    affiliate_program: types.TransactionPartnerAffiliateProgram,
    fragment: types.TransactionPartnerFragment,
    telegram_ads: types.TransactionPartnerTelegramAds,
    telegram_api: types.TransactionPartnerTelegramApi,
    other: types.TransactionPartnerOther,

    const Self = @This();

    pub fn jsonParse(allocator: std.mem.Allocator, source: anytype, options: std.json.ParseOptions) !Self {
        return utils.json.parseTaggedUnion(Self, enums.TransactionPartnerType, allocator, source, options);
    }
};
