pub const ApproveSuggestedPost = struct {
    chat_id: i32,
    message_id: i32,
    send_date: ?i32 = null,

    pub const ReturnType = bool;
    pub const api_method = "approveSuggestedPost";
};
