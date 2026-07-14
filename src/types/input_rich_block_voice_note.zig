const enums = @import("enums");
const types = @import("types");

type: enums.InputRichBlockType = .voice_note,
voice_note: types.InputMediaVoiceNote,
caption: ?types.RichBlockCaption = null,
