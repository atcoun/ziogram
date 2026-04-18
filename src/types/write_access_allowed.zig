pub const WriteAccessAllowed = struct {
    from_request: ?bool = null,
    web_app_name: ?[]const u8 = null,
    from_attachment_menu: ?bool = null,
};
