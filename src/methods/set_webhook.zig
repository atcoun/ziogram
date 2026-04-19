const enums = @import("enums");
const types = @import("types");

pub const ReturnType = bool;
pub const api_method = "setWebhook";

url: []const u8,
certificate: ?types.InputFile = null,
ip_address: ?[]const u8 = null,
max_connections: ?i32 = null,
allowed_updates: ?[]const enums.UpdateType = null,
drop_pending_updates: ?bool = null,
secret_token: ?[]const u8 = null,
