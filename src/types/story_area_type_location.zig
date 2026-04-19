const enums = @import("enums");
const types = @import("types");

type: enums.StoryAreaKind = .location,
latitude: f32,
longitude: f32,
address: ?types.LocationAddress = null,
