pub const DeleteWebhook = struct {
    drop_pending_updates: ?bool = null,

    pub const ReturnType = bool;
    pub const api_method = "deleteWebhook";
};
