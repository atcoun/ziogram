const enums = @import("../enums.zig");
const types = @import("../types.zig");

pub const EditStory = struct {
    business_connection_id: []const u8,
    story_id: i32,
    content: ?types.InputStoryContent = null,
    caption: ?[]const u8 = null,
    parse_mode: ?enums.ParseMode = null,
    caption_entities: ?[]const types.MessageEntity = null,
    areas: ?[]const types.StoryArea = null,

    pub const ReturnType = types.Story;
    pub const api_method = "editStory";
};
