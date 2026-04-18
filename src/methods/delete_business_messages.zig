pub const DeleteBusinessMessages = struct {
    business_connection_id: []const u8,
    message_ids: []const i32,

    pub const ReturnType = bool;
    pub const api_method = "deleteBusinessMessages";
};
