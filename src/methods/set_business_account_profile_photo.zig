const types = @import("types");

pub const ReturnType = bool;
pub const api_method = "setBusinessAccountProfilePhoto";

business_connection_id: []const u8,
photo: types.InputProfilePhoto,
is_public: ?bool = null,
