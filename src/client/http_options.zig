const std = @import("std");
const http = std.http;

const TelegramAPI = @import("../client/api.zig");

api: TelegramAPI = TelegramAPI.PRODUCTION,
proxy: ?*const http.Client.Proxy = null,
