const enums = @import("enums");
const types = @import("types");

type: enums.RichBlockType = .voice_note,
voice_note: types.Voice,
caption: ?types.RichBlockCaption = null,
