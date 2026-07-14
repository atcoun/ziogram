const enums = @import("enums");
const types = @import("types");

type: enums.InputRichBlockType = .audio,
audio: types.InputMediaAudio,
caption: ?types.RichBlockCaption = null,
