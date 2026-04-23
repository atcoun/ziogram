const types = @import("types");

pub const Result = bool;
pub const method_name = "setBusinessAccountProfilePhoto";

business_connection_id: []const u8,
photo: types.InputProfilePhoto,
is_public: ?bool = null,
