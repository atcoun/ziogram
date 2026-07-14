const types = @import("types");

blocks: ?[]const types.InputRichBlock = null,
html: ?[]const u8 = null,
markdown: ?[]const u8 = null,
media: ?[]const types.InputRichMessageMedia = null,
is_rtl: ?bool = null,
skip_entity_detection: ?bool = null,
