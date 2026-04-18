pub const SetMyShortDescription = struct {
    short_description: ?[]const u8 = null,
    language_code: ?[]const u8 = null,

    pub const ReturnType = bool;
    pub const api_method = "setMyShortDescription";
};
