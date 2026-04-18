const types = @import("../types.zig");

pub const GetAvailableGifts = struct {
    pub const ReturnType = types.Gifts;
    pub const api_method = "getAvailableGifts";
};
