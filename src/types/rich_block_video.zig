const enums = @import("enums");
const types = @import("types");

type: enums.RichBlockType = .video,
video: types.Video,
has_spoiler: ?bool = null,
caption: ?types.RichBlockCaption = null,
