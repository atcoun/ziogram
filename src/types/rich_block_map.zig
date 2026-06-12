const enums = @import("enums");
const types = @import("types");

type: enums.RichBlockType = .map,
location: types.Location,
zoom: i32,
width: i32,
height: i32,
caption: ?types.RichBlockCaption = null,
