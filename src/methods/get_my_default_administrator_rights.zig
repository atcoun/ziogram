const types = @import("../types.zig");

pub const GetMyDefaultAdministratorRights = struct {
    for_channels: ?bool = null,

    pub const ReturnType = types.ChatAdministratorRights;
    pub const api_method = "getMyDefaultAdministratorRights";
};
