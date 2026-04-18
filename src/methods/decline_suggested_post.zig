pub const DeclineSuggestedPost = struct {
    chat_id: i32,
    message_id: i32,
    comment: ?[]const u8 = null,

    pub const ReturnType = bool;
    pub const api_method = "declineSuggestedPost";
};
