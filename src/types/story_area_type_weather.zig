const enums = @import("../enums.zig");

pub const StoryAreaTypeWeather = struct {
    type: enums.StoryAreaKind = .weather,
    temperature: f32,
    emoji: []const u8,
    background_color: i32,
};
