const enums = @import("enums");
const types = @import("types");

name: []const u8,
title: []const u8,
sticker_type: enums.StickerType,
stickers: []const types.Sticker,
thumbnail: ?types.PhotoSize = null,
