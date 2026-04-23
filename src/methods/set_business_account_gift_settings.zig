const types = @import("types");

pub const Result = bool;
pub const method_name = "setBusinessAccountGiftSettings";

business_connection_id: []const u8,
show_gift_button: bool,
accepted_gift_types: types.AcceptedGiftTypes,
