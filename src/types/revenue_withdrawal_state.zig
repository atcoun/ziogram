const std = @import("std");

const enums = @import("enums");
const types = @import("types");

pub const RevenueWithdrawalState = union(enum) {
    pending: types.RevenueWithdrawalStatePending,
    succeeded: types.RevenueWithdrawalStateSucceeded,
    failed: types.RevenueWithdrawalStateFailed,

    pub fn jsonParse(allocator: std.mem.Allocator, source: anytype, options: std.json.ParseOptions) !@This() {
        const value = try std.json.innerParse(std.json.Value, allocator, source, options);
        const type_str = if (value.object.get("type")) |t| t.string else return error.MissingField;
        const state_type = std.meta.stringToEnum(enums.RevenueWithdrawalStateType, type_str) orelse return error.UnknownType;

        return switch (state_type) {
            .pending => .{ .pending = try std.json.innerParseFromValue(types.RevenueWithdrawalStatePending, allocator, value, options) },
            .succeeded => .{ .succeeded = try std.json.innerParseFromValue(types.RevenueWithdrawalStateSucceeded, allocator, value, options) },
            .failed => .{ .failed = try std.json.innerParseFromValue(types.RevenueWithdrawalStateFailed, allocator, value, options) },
        };
    }
};
