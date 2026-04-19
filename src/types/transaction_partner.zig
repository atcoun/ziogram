const std = @import("std");

const enums = @import("enums");
const types = @import("types");

pub const TransactionPartner = union(enum) {
    user: types.TransactionPartnerUser,
    chat: types.TransactionPartnerChat,
    affiliate_program: types.TransactionPartnerAffiliateProgram,
    fragment: types.TransactionPartnerFragment,
    telegram_ads: types.TransactionPartnerTelegramAds,
    telegram_api: types.TransactionPartnerTelegramApi,
    other: types.TransactionPartnerOther,

    pub fn jsonParse(allocator: std.mem.Allocator, source: anytype, options: std.json.ParseOptions) !@This() {
        const value = try std.json.innerParse(std.json.Value, allocator, source, options);
        const type_str = if (value.object.get("type")) |t| t.string else return error.MissingField;
        const partner_type = std.meta.stringToEnum(enums.TransactionPartnerType, type_str) orelse return error.UnknownType;

        return switch (partner_type) {
            .user => .{ .user = try std.json.innerParseFromValue(types.TransactionPartnerUser, allocator, value, options) },
            .chat => .{ .chat = try std.json.innerParseFromValue(types.TransactionPartnerChat, allocator, value, options) },
            .affiliate_program => .{ .affiliate_program = try std.json.innerParseFromValue(types.TransactionPartnerAffiliateProgram, allocator, value, options) },
            .fragment => .{ .fragment = try std.json.innerParseFromValue(types.TransactionPartnerFragment, allocator, value, options) },
            .telegram_ads => .{ .telegram_ads = try std.json.innerParseFromValue(types.TransactionPartnerTelegramAds, allocator, value, options) },
            .telegram_api => .{ .telegram_api = try std.json.innerParseFromValue(types.TransactionPartnerTelegramApi, allocator, value, options) },
            .other => .{ .other = try std.json.innerParseFromValue(types.TransactionPartnerOther, allocator, value, options) },
        };
    }
};
