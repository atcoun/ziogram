const enums = @import("enums");
const types = @import("types");

pub const ReturnType = types.Story;
pub const api_method = "postStory";

business_connection_id: []const u8,
content: types.InputStoryContent,
active_period: i32,
caption: ?[]const u8 = null,
parse_mode: ?enums.ParseMode = null,
caption_entities: ?[]const types.MessageEntity = null,
areas: ?[]const types.StoryArea = null,
post_to_chat_page: ?bool = null,
protect_content: ?bool = null,
