const types = @import("../types.zig");

pub const SetBusinessAccountProfilePhoto = struct {
    business_connection_id: []const u8,
    photo: types.InputProfilePhoto,
    is_public: ?bool = null,

    pub const ReturnType = bool;
    pub const api_method = "setBusinessAccountProfilePhoto";
};
