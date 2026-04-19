const enums = @import("enums");

source: enums.PassportElementErrorSource = .data,
type: enums.PassportElementType,
field_name: []const u8,
data_hash: []const u8,
message: []const u8,
