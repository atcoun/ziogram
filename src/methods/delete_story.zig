pub const DeleteStory = struct {
    business_connection_id: []const u8,
    story_id: i32,

    pub const ReturnType = bool;
    pub const api_method = "deleteStory";
};
