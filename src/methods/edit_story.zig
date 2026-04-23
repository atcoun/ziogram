const enums = @import("enums");
const types = @import("types");

pub const Result = types.Story;
pub const method_name = "editStory";

business_connection_id: []const u8,
story_id: i32,
content: ?types.InputStoryContent = null,
caption: ?[]const u8 = null,
parse_mode: ?enums.ParseMode = null,
caption_entities: ?[]const types.MessageEntity = null,
areas: ?[]const types.StoryArea = null,
