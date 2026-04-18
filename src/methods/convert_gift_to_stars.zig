pub const ConvertGiftToStars = struct {
    business_connection_id: []const u8,
    owned_gift_id: []const u8,

    pub const ReturnType = bool;
    pub const api_method = "convertGiftToStars";
};
