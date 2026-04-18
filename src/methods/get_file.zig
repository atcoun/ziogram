const types = @import("../types.zig");

pub const GetFile = struct {
    file_id: []const u8,

    pub const ReturnType = types.File;
    pub const api_method = "getFile";
};
