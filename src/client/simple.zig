const SimpleFilesPathWrapper = @This();

const std = @import("std");

server_path: []const u8,
local_path: []const u8,

pub fn toLocal(
    self: *const SimpleFilesPathWrapper,
    allocator: std.mem.Allocator,
    path: []const u8,
) ![]const u8 {
    return std.mem.concat(
        allocator,
        u8,
        &.{ self.local_path, std.mem.cutPrefix(u8, path, self.server_path) orelse path },
    );
}

pub fn toServer(
    self: *const SimpleFilesPathWrapper,
    allocator: std.mem.Allocator,
    path: []const u8,
) ![]const u8 {
    return std.mem.concat(
        allocator,
        u8,
        &.{ self.server_path, std.mem.cutPrefix(u8, path, self.local_path) orelse path },
    );
}
