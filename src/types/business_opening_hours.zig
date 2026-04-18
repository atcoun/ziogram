const types = @import("../types.zig");

pub const BusinessOpeningHours = struct {
    time_zone_name: []const u8,
    opening_hours: []const types.BusinessOpeningHoursInterval,
};
