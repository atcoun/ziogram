const std = @import("std");

pub const FilesPathWrapper = union(enum) {
    bare: void,
    simple: struct {
        server_path: []const u8,
        local_path: []const u8,
    },

    pub fn toLocal(self: @This(), allocator: std.mem.Allocator, path: []const u8) ![]const u8 {
        return self.transform(allocator, path, true);
    }

    pub fn toServer(self: @This(), allocator: std.mem.Allocator, path: []const u8) ![]const u8 {
        return self.transform(allocator, path, false);
    }

    fn transform(self: @This(), allocator: std.mem.Allocator, path: []const u8, local: bool) ![]const u8 {
        if (self == .bare) return try allocator.dupe(u8, path);
        const s = self.simple;
        const from, const to = if (local) .{ s.server_path, s.local_path } else .{ s.local_path, s.server_path };

        if (std.mem.cutPrefix(u8, path, from)) |relative|
            return try std.fs.path.resolve(allocator, &.{ to, relative });
        return try allocator.dupe(u8, path);
    }
};

pub const TelegramAPI = struct {
    base: []const u8,
    file: []const u8,
    is_local: bool = false,
    wrap_local_file: FilesPathWrapper = .bare,
    is_owned: bool = false,

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

    pub fn fromBase(allocator: std.mem.Allocator, base_url: []const u8, is_local: bool) !@This() {
        const root = std.mem.trimEnd(u8, base_url, "/");
        return .{
            .base = try std.fmt.allocPrint(allocator, "{s}/bot{{token}}/{{method}}", .{root}),
            .file = try std.fmt.allocPrint(allocator, "{s}/file/bot{{token}}/{{path}}", .{root}),
            .is_local = is_local,
            .is_owned = true,
        };
    }

    pub fn deinit(self: *@This(), allocator: std.mem.Allocator) void {
        if (self.is_owned) {
            allocator.free(self.base);
            allocator.free(self.file);
        }
    }
};

pub const PRODUCTION = TelegramAPI{
    .base = "https://api.telegram.org/bot{token}/{method}",
    .file = "https://api.telegram.org/file/bot{token}/{path}",
};

pub const TEST = TelegramAPI{
    .base = "https://api.telegram.org/bot{token}/test/{method}",
    .file = "https://api.telegram.org/file/bot{token}/test/{path}",
};
