const enums = @import("enums");
const types = @import("types");

type: enums.RichBlockType = .photo,
photo: []const types.PhotoSize,
has_spoiler: ?bool = null,
caption: ?types.RichBlockCaption = null,
