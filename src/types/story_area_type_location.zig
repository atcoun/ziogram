const enums = @import("../enums.zig");
const types = @import("../types.zig");

pub const StoryAreaTypeLocation = struct {
    type: enums.StoryAreaKind = .location,
    latitude: f32,
    longitude: f32,
    address: ?types.LocationAddress = null,
};
