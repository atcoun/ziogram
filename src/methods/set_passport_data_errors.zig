const types = @import("types");

pub const ReturnType = bool;
pub const api_method = "setPassportDataErrors";

user_id: i64,
errors: []const types.PassportElementError,
