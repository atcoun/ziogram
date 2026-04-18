const types = @import("../types.zig");

pub const SetPassportDataErrors = struct {
    user_id: i32,
    errors: []const types.PassportElementError,

    pub const ReturnType = bool;
    pub const api_method = "setPassportDataErrors";
};
