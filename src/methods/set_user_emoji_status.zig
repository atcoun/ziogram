pub const SetUserEmojiStatus = struct {
    user_id: i64,
    emoji_status_custom_emoji_id: ?[]const u8 = null,
    emoji_status_expiration_date: ?i32 = null,

    pub const ReturnType = bool;
    pub const api_method = "setUserEmojiStatus";
};
