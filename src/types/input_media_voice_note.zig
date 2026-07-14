const enums = @import("enums");
const types = @import("types");

type: enums.InputMediaType = .voice_note,
media: types.InputFile,
caption: ?[]const u8 = null,
parse_mode: ?[]const u8 = null,
caption_entities: ?[]const types.MessageEntity = null,
duration: ?i32 = null,
