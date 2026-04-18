const types = @import("../types.zig");

pub const SetBusinessAccountGiftSettings = struct {
    business_connection_id: []const u8,
    show_gift_button: bool,
    accepted_gift_types: types.AcceptedGiftTypes,

    pub const ReturnType = bool;
    pub const api_method = "setBusinessAccountGiftSettings";
};
