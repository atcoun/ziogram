const types = @import("../types.zig");

pub const GetWebhookInfo = struct {
    pub const ReturnType = types.WebhookInfo;
    pub const api_method = "getWebhookInfo";
};
