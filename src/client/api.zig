const std = @import("std");

const LocalPaths = @import("local_paths.zig");

pub const FilesPathWrapper = union(enum) {
    bare: void,
    simple: LocalPaths,

    pub fn toLocal(self: @This(), allocator: std.mem.Allocator, path: []const u8) ![]const u8 {
        if (self == .bare) return try allocator.dupe(u8, path);
        const s = self.simple;

        if (std.mem.cutPrefix(u8, path, s.server_path)) |relative|
            return try std.fs.path.resolve(allocator, &.{ s.local_path, relative });
        return try allocator.dupe(u8, path);
    }
};

base: []const u8,
file: []const u8,
is_local: bool = false,
wrap_local_file: FilesPathWrapper = .bare,

pub fn apiUrl(self: @This(), allocator: std.mem.Allocator, token: []const u8, method: []const u8) ![]const u8 {
    return self.format(allocator, self.base, "{token}", token, "{method}", method);
}

pub fn fileUrl(self: @This(), allocator: std.mem.Allocator, token: []const u8, path: []const u8) ![]const u8 {
    return self.format(allocator, self.file, "{token}", token, "{path}", path);
}

fn format(self: @This(), allocator: std.mem.Allocator, template: []const u8, k1: []const u8, v1: []const u8, k2: []const u8, v2: []const u8) ![]const u8 {
    _ = self;
    const c1 = std.mem.cut(u8, template, k1) orelse return error.InvalidTemplate;
    const c2 = std.mem.cut(u8, c1.@"1", k2) orelse return error.InvalidTemplate;
    return try std.fmt.allocPrint(allocator, "{s}{s}{s}{s}{s}", .{ c1.@"0", v1, c2.@"0", v2, c2.@"1" });
}

pub fn fromBase(allocator: std.mem.Allocator, base_url: []const u8, local_paths: ?LocalPaths) !@This() {
    const root = std.mem.trimEnd(u8, base_url, "/");
    const is_local = std.mem.startsWith(u8, root, "http://");
    return .{
        .base = try std.fmt.allocPrint(allocator, "{s}/bot{{token}}/{{method}}", .{root}),
        .file = try std.fmt.allocPrint(allocator, "{s}/file/bot{{token}}/{{path}}", .{root}),
        .is_local = is_local,
        .wrap_local_file = if (local_paths) |p| .{ .simple = p } else .bare,
    };
}

pub fn deinit(self: *@This(), allocator: std.mem.Allocator) void {
    allocator.free(self.base);
    allocator.free(self.file);
}

pub const PRODUCTION = @This(){
    .base = "https://api.telegram.org/bot{token}/{method}",
    .file = "https://api.telegram.org/file/bot{token}/{path}",
};

pub const TEST = @This(){
    .base = "https://api.telegram.org/bot{token}/test/{method}",
    .file = "https://api.telegram.org/file/bot{token}/test/{path}",
};

test "PRODUCTION apiUrl" {
    const allocator = std.testing.allocator;
    const url = try PRODUCTION.apiUrl(allocator, "TOKEN", "getMe");
    defer allocator.free(url);
    try std.testing.expectEqualStrings(
        "https://api.telegram.org/botTOKEN/getMe",
        url,
    );
}

test "PRODUCTION fileUrl" {
    const allocator = std.testing.allocator;
    const url = try PRODUCTION.fileUrl(allocator, "TOKEN", "photos/file_0.jpg");
    defer allocator.free(url);
    try std.testing.expectEqualStrings(
        "https://api.telegram.org/file/botTOKEN/photos/file_0.jpg",
        url,
    );
}

test "TEST apiUrl" {
    const allocator = std.testing.allocator;
    const url = try TEST.apiUrl(allocator, "TOKEN", "sendMessage");
    defer allocator.free(url);
    try std.testing.expectEqualStrings(
        "https://api.telegram.org/botTOKEN/test/sendMessage",
        url,
    );
}

test "fromBase http is_local=true" {
    const allocator = std.testing.allocator;
    var api = try fromBase(allocator, "http://localhost:8081", null);
    defer api.deinit(allocator);
    try std.testing.expect(api.is_local == true);
}

test "fromBase https is_local=false" {
    const allocator = std.testing.allocator;
    var api = try fromBase(allocator, "https://api.telegram.org", null);
    defer api.deinit(allocator);
    try std.testing.expect(api.is_local == false);
}

test "fromBase trailing slash stripped" {
    const allocator = std.testing.allocator;
    var api = try fromBase(allocator, "http://localhost:8081/", null);
    defer api.deinit(allocator);
    const url = try api.apiUrl(allocator, "TOKEN", "getMe");
    defer allocator.free(url);
    try std.testing.expectEqualStrings("http://localhost:8081/botTOKEN/getMe", url);
}

test "toLocal bare returns same path" {
    const allocator = std.testing.allocator;
    const wrapper = FilesPathWrapper{ .bare = {} };
    const result = try wrapper.toLocal(allocator, "/some/path/file.jpg");
    defer allocator.free(result);
    try std.testing.expectEqualStrings("/some/path/file.jpg", result);
}

test "toLocal simple remaps server path" {
    const allocator = std.testing.allocator;
    const wrapper = FilesPathWrapper{ .simple = .{
        .server_path = "/var/lib/telegram-bot-api/",
        .local_path = "/mnt/storage/",
    } };
    const result = try wrapper.toLocal(allocator, "/var/lib/telegram-bot-api/photos/file.jpg");
    defer allocator.free(result);
    try std.testing.expect(std.mem.endsWith(u8, result, "photos/file.jpg"));
    try std.testing.expect(std.mem.startsWith(u8, result, "/mnt/storage"));
}

test "toLocal simple unknown path returns as-is" {
    const allocator = std.testing.allocator;
    const wrapper = FilesPathWrapper{ .simple = .{
        .server_path = "/var/lib/telegram-bot-api/",
        .local_path = "/mnt/storage/",
    } };
    const result = try wrapper.toLocal(allocator, "/other/path/file.jpg");
    defer allocator.free(result);
    try std.testing.expectEqualStrings("/other/path/file.jpg", result);
}
