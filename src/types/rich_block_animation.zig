const enums = @import("enums");
const types = @import("types");

type: enums.RichBlockType = .animation,
animation: types.Animation,
has_spoiler: ?bool = null,
caption: ?types.RichBlockCaption = null,
