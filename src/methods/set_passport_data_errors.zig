const types = @import("types");

pub const Result = bool;
pub const method_name = "setPassportDataErrors";

user_id: i64,
errors: []const types.PassportElementError,
