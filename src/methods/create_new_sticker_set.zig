const enums = @import("enums");
const types = @import("types");

pub const Result = bool;
pub const method_name = "createNewStickerSet";

user_id: i64,
name: []const u8,
title: []const u8,
stickers: []const types.InputSticker,
sticker_type: ?enums.StickerType = null,
needs_repainting: ?bool = null,
