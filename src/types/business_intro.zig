const types = @import("../types.zig");

pub const BusinessIntro = struct {
    title: ?[]const u8 = null,
    message: ?[]const u8 = null,
    sticker: ?types.Sticker = null,
};
