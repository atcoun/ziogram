const types = @import("types");

pub const ReturnType = bool;
pub const api_method = "setBusinessAccountGiftSettings";

business_connection_id: []const u8,
show_gift_button: bool,
accepted_gift_types: types.AcceptedGiftTypes,
