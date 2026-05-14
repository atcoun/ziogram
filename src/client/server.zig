const TelegramApi = @This();

const std = @import("std");

const SimpleFilesPathWrapper = @import("./simple.zig");

pub const FilesPathWrapper = union(enum) {
    bare,
    simple: SimpleFilesPathWrapper,

    pub fn toLocal(
        self: *const @This(),
        allocator: std.mem.Allocator,
        path: []const u8,
    ) ![]const u8 {
        return switch (self.*) {
            .bare => allocator.dupe(u8, path),
            .simple => |w| w.toLocal(allocator, path),
        };
    }

    pub fn toServer(
        self: *const @This(),
        allocator: std.mem.Allocator,
        path: []const u8,
    ) ![]const u8 {
        return switch (self.*) {
            .bare => allocator.dupe(u8, path),
            .simple => |w| w.toServer(allocator, path),
        };
    }
};

base: []const u8,
is_test: bool = false,
is_local: bool = false,
wrap_local_file: FilesPathWrapper = .bare,

pub fn apiUrl(
    self: *const TelegramApi,
    allocator: std.mem.Allocator,
    token: []const u8,
    method: []const u8,
) ![]const u8 {
    if (self.is_test) {
        return std.mem.concat(
            allocator,
            u8,
            &.{ self.base, "/bot", token, "/test/", method },
        );
    }
    return std.mem.concat(
        allocator,
        u8,
        &.{ self.base, "/bot", token, "/", method },
    );
}

pub fn fileUrl(
    self: *const TelegramApi,
    allocator: std.mem.Allocator,
    token: []const u8,
    path: []const u8,
) ![]const u8 {
    if (self.is_test) {
        return std.mem.concat(
            allocator,
            u8,
            &.{ self.base, "/file/bot", token, "/test/", path },
        );
    }
    return std.mem.concat(
        allocator,
        u8,
        &.{ self.base, "/file/bot", token, "/", path },
    );
}

pub const production: TelegramApi = .{ .base = "https://api.telegram.org" };
pub const testing: TelegramApi = .{ .base = "https://api.telegram.org", .is_test = true };

test "production apiUrl" {
    const allocator = std.testing.allocator;
    const url = try production.apiUrl(allocator, "TOKEN", "getMe");
    defer allocator.free(url);
    try std.testing.expectEqualStrings(
        "https://api.telegram.org/botTOKEN/getMe",
        url,
    );
}

test "production fileUrl" {
    const allocator = std.testing.allocator;
    const url = try production.fileUrl(allocator, "TOKEN", "photos/file_0.jpg");
    defer allocator.free(url);
    try std.testing.expectEqualStrings(
        "https://api.telegram.org/file/botTOKEN/photos/file_0.jpg",
        url,
    );
}

test "testing apiUrl" {
    const allocator = std.testing.allocator;
    const url = try testing.apiUrl(allocator, "TOKEN", "sendMessage");
    defer allocator.free(url);
    try std.testing.expectEqualStrings(
        "https://api.telegram.org/botTOKEN/test/sendMessage",
        url,
    );
}

test "http is_local=true" {
    const server: TelegramApi = .{
        .base = "http://localhost:8081",
        .is_local = true,
    };
    try std.testing.expect(server.is_local == true);
}

test "https is_local=false" {
    const server: TelegramApi = .{
        .base = "https://api.telegram.org",
        .is_local = false,
    };
    try std.testing.expect(server.is_local == false);
}

test "with local paths" {
    const server: TelegramApi = .{
        .base = "http://localhost:8081",
        .is_local = true,
        .wrap_local_file = .{
            .simple = .{
                .local_path = "/var/lib/telegram-bot-api/",
                .server_path = "/mnt/storage/",
            },
        },
    };
    try std.testing.expect(server.is_local == true);
    try std.testing.expect(server.wrap_local_file == .simple);
}

test "trailing slash stripped" {
    const server: TelegramApi = .{
        .base = "http://localhost:8081",
        .is_local = true,
    };
    const allocator = std.testing.allocator;
    const url = try server.apiUrl(allocator, "TOKEN", "getMe");
    defer allocator.free(url);
    try std.testing.expectEqualStrings("http://localhost:8081/botTOKEN/getMe", url);
}

test "toLocal bare returns same path" {
    const allocator = std.testing.allocator;
    const wrapper: FilesPathWrapper = .{ .bare = {} };
    const result = try wrapper.toLocal(allocator, "/some/path/file.jpg");
    defer allocator.free(result);
    try std.testing.expectEqualStrings("/some/path/file.jpg", result);
}

test "toLocal simple remaps server path" {
    const allocator = std.testing.allocator;
    const wrapper: FilesPathWrapper = .{ .simple = .{
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
    const wrapper: FilesPathWrapper = .{ .simple = .{
        .server_path = "/var/lib/telegram-bot-api/",
        .local_path = "/mnt/storage/",
    } };
    const result = try wrapper.toLocal(allocator, "/other/path/file.jpg");
    defer allocator.free(result);
    try std.testing.expectEqualStrings("/mnt/storage//other/path/file.jpg", result);
}

test "toServer bare returns same path" {
    const allocator = std.testing.allocator;
    const wrapper: FilesPathWrapper = .{ .bare = {} };
    const result = try wrapper.toServer(allocator, "/some/path/file.jpg");
    defer allocator.free(result);
    try std.testing.expectEqualStrings("/some/path/file.jpg", result);
}

test "toServer simple remaps local path" {
    const allocator = std.testing.allocator;
    const wrapper: FilesPathWrapper = .{ .simple = .{
        .server_path = "/var/lib/telegram-bot-api/",
        .local_path = "/mnt/storage/",
    } };
    const result = try wrapper.toServer(allocator, "/mnt/storage/photos/file.jpg");
    defer allocator.free(result);
    try std.testing.expect(std.mem.endsWith(u8, result, "photos/file.jpg"));
    try std.testing.expect(std.mem.startsWith(u8, result, "/var/lib/telegram-bot-api"));
}

test "toServer simple unknown path returns as-is" {
    const allocator = std.testing.allocator;
    const wrapper: FilesPathWrapper = .{ .simple = .{
        .server_path = "/var/lib/telegram-bot-api/",
        .local_path = "/mnt/storage/",
    } };
    const result = try wrapper.toServer(allocator, "/other/path/file.jpg");
    defer allocator.free(result);
    try std.testing.expectEqualStrings("/var/lib/telegram-bot-api//other/path/file.jpg", result);
}
