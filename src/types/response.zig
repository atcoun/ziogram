const types = @import("../types.zig");

pub fn Response(comptime T: type) type {
    return struct {
        ok: bool,
        result: ?T = null,
        description: ?[]const u8 = null,
        error_code: ?i32 = null,
        parameters: ?types.ResponseParameters = null,
    };
}
