pub const ReadBusinessMessage = struct {
    business_connection_id: []const u8,
    chat_id: i32,
    message_id: i32,

    pub const ReturnType = bool;
    pub const api_method = "readBusinessMessage";
};
