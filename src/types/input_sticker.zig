const enums = @import("enums");
const types = @import("types");

sticker: []const u8,
format: enums.InputStickerFormat,
emoji_list: []const []const u8,
mask_position: ?types.MaskPosition = null,
keywords: ?[]const []const u8 = null,
