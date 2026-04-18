const enums = @import("../enums.zig");
const types = @import("../types.zig");

pub const PostStory = struct {
    business_connection_id: []const u8,
    content: types.InputStoryContent,
    active_period: i32,
    caption: ?[]const u8 = null,
    parse_mode: ?enums.ParseMode = null,
    caption_entities: ?[]const types.MessageEntity = null,
    areas: ?[]const types.StoryArea = null,
    post_to_chat_page: ?bool = null,
    protect_content: ?bool = null,

    pub const ReturnType = types.Story;
    pub const api_method = "postStory";
};
