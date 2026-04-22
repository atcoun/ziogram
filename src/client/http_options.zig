const std = @import("std");
const http = std.http;

const TelegramAPI = @import("../client/api.zig");

read_buffer_size: usize = 8192,
write_buffer_size: usize = 1024,
api: TelegramAPI = TelegramAPI.PRODUCTION,
proxy: ?*const http.Client.Proxy = null,
