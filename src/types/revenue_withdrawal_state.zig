const std = @import("std");

const enums = @import("enums");
const types = @import("types");
const utils = @import("utils");

pub const RevenueWithdrawalState = union(enum) {
    pending: types.RevenueWithdrawalStatePending,
    succeeded: types.RevenueWithdrawalStateSucceeded,
    failed: types.RevenueWithdrawalStateFailed,

    const Self = @This();

    pub fn jsonParse(allocator: std.mem.Allocator, source: anytype, options: std.json.ParseOptions) !Self {
        return utils.json.parseTaggedUnion(Self, enums.RevenueWithdrawalStateType, allocator, source, options);
    }
};
