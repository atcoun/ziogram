const enums = @import("enums");
const types = @import("types");

type: enums.InputRichBlockType = .photo,
photo: types.InputMediaPhoto,
caption: ?types.RichBlockCaption = null,
