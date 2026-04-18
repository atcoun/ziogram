const types = @import("../types.zig");

pub const SetMyDefaultAdministratorRights = struct {
    rights: ?types.ChatAdministratorRights = null,
    for_channels: ?bool = null,

    pub const ReturnType = bool;
    pub const api_method = "setMyDefaultAdministratorRights";
};
