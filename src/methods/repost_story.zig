const types = @import("../types.zig");

pub const RepostStory = struct {
    business_connection_id: []const u8,
    from_chat_id: i32,
    from_story_id: i32,
    active_period: i32,
    post_to_chat_page: ?bool = null,
    protect_content: ?bool = null,

    pub const ReturnType = types.Story;
    pub const api_method = "repostStory";
};
