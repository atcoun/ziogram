const std = @import("std");
const http = std.http;

const TelegramAPI = @import("../client/api.zig");

pool_size: usize = 100,
api: TelegramAPI = TelegramAPI.PRODUCTION,
proxy: ?*const http.Client.Proxy = null,
